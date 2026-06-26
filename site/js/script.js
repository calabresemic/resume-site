// Mobile nav toggle
const nav = document.querySelector('.index');
const toggle = document.querySelector('.index__toggle');

if (toggle && nav) {
  toggle.addEventListener('click', () => {
    const isOpen = nav.classList.toggle('is-open');
    toggle.setAttribute('aria-expanded', String(isOpen));
  });

  // Close menu after picking a section (mobile)
  nav.querySelectorAll('.index__list a').forEach(link => {
    link.addEventListener('click', () => {
      nav.classList.remove('is-open');
      toggle.setAttribute('aria-expanded', 'false');
    });
  });
}

// Highlight the active section in the index nav while scrolling
const sections = document.querySelectorAll('main .section, main .contact');
const navLinks = document.querySelectorAll('.index__list a');

if ('IntersectionObserver' in window && sections.length) {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const id = entry.target.getAttribute('id');
        navLinks.forEach(link => {
          const href = link.getAttribute('href') || '';
          // Only toggle highlight for same-page hash links; leave
          // cross-page links (e.g. projects.html) and the manually
          // applied .is-active class alone.
          if (href.startsWith('#')) {
            link.style.color = href === `#${id}` ? 'var(--ink)' : '';
          }
        });
      }
    });
  }, { rootMargin: '-40% 0px -50% 0px' });

  sections.forEach(section => observer.observe(section));
}
