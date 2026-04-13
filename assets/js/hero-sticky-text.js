(function () {
  function init() {
    var heroBanner = document.querySelector('.hero-banner');
    var heroText = document.querySelector('.hero-text');
    var navbar = document.getElementById('navbar');

    if (!heroBanner || !heroText) return;

    var heroHeight, maxTranslate;

    function recalc() {
      heroHeight = heroBanner.offsetHeight;
      var heroTop = heroBanner.getBoundingClientRect().top + window.scrollY;
      var textTop = heroText.getBoundingClientRect().top + window.scrollY;
      var textOffsetInHero = textTop - heroTop;
      // Text starts at ~25% down the hero; stop it moving when it reaches 75%
      maxTranslate = 0.75 * heroHeight - textOffsetInHero;
      if (maxTranslate < 0) maxTranslate = 0;
    }

    function updateNavbar() {
      if (!navbar) return;
      var navH = navbar.offsetHeight;
      if (window.scrollY <= navH) {
        navbar.classList.add('navbar-hero-transparent');
      } else {
        navbar.classList.remove('navbar-hero-transparent');
      }
    }

    function update() {
      var t = Math.min(Math.max(window.scrollY, 0), maxTranslate);
      heroText.style.transform = 'translateY(' + t + 'px)';
      updateNavbar();
    }

    recalc();
    update();

    window.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', function () { recalc(); update(); });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
