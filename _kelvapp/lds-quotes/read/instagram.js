/* Native Instagram profile preview. Loads automatically; profile link remains available. */
(function () {
  'use strict';
  const button = document.getElementById('instagram-load');
  const preview = document.getElementById('instagram-preview');
  const template = document.getElementById('instagram-template');
  const status = document.getElementById('instagram-status');
  if (!button || !preview || !template || !status) return;
  let requested = false;
  let activeScript;
  function loadPreview() {
    if (requested) return;
    requested = true;
    button.hidden = true;
    button.disabled = true;
    button.setAttribute('aria-expanded', 'true');
    preview.hidden = false;
    preview.replaceChildren(template.content.cloneNode(true));
    status.textContent = 'Loading from Instagram. The full-profile link is always available.';
    if (activeScript) activeScript.remove();
    const script = document.createElement('script');
    activeScript = script;
    script.src = 'https://www.instagram.com/embed.js';
    script.async = true;
    let timer;
    const failure = function () {
      clearTimeout(timer);
      status.textContent = 'The preview could not load. You can try again or use the full-profile link above.';
      button.textContent = 'Try Instagram preview again';
      button.hidden = false;
      button.disabled = false;
      requested = false;
      script.remove();
    };
    script.onerror = failure;
    script.onload = function () {
      clearTimeout(timer);
      status.textContent = 'Instagram controls the preview below. If it is unavailable, use the full-profile link above.';
    };
    timer = setTimeout(function () {
      status.textContent = 'Instagram is taking longer to respond. You can use the full-profile link above.';
    }, 12000);
    document.head.appendChild(script);
  }
  button.addEventListener('click', loadPreview);
  loadPreview();
}());
