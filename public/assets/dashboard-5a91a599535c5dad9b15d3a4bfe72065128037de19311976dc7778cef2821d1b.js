var Tabs = {

  el: {
    nav: $(".accordion-tabs"),
    tabs: $(".accordion-tabs > li > a"),
    panels: $(".accordion-tabs > li > section")
  },

  init: function() {
    Tabs.bindUIActions();
  },

  bindUIActions: function() {
    Tabs.el.nav
      .on(
        'click',
        'li > a:not(.active)',
        function(event) {
          Tabs.deactivateAll();
          Tabs.activateTab(event);
          event.preventDefault();
        }
      );
  },
  
  deactivateAll: function() {
    Tabs.el.tabs.removeClass("active");
    Tabs.el.panels.removeClass("is-open");
  },

  activateTab: function(event) {
    $(event.target)
      .addClass("active")
      .next()
      .addClass("is-open");
  }

};

Tabs.init();
