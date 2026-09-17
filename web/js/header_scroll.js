// Simple header scroll behavior
window.HeaderScroll = {
  // Configuration
  scrollThreshold: 100,
  headerSelector: '#main-header',

  // Initialize scroll listener
  init: function() {
    console.log('HeaderScroll initialized');
  },

  // Get current scroll position
  getScrollPosition: function() {
    return window.pageYOffset || document.documentElement.scrollTop;
  },

  // Check if header should be in scrolled state
  isHeaderScrolled: function() {
    const scrollY = this.getScrollPosition();
    return scrollY > this.scrollThreshold;
  },

  // Get the appropriate header class name based on scroll position
  getHeaderClassName: function() {
    return this.isHeaderScrolled() ? 'scrolled' : 'at-top';
  },

  // Update scroll threshold
  setThreshold: function(threshold) {
    this.scrollThreshold = threshold;
  },

  // Update header selector
  setSelector: function(selector) {
    this.headerSelector = selector;
  },

  // Cleanup (for now just logs)
  destroy: function() {
    console.log('HeaderScroll destroyed');
  }
};