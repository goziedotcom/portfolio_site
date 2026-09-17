window.CustomScroll = {
  // Default animation duration
  defaultDuration: 800,

  // Smooth scroll to top
  toTop: function(duration = this.defaultDuration) {
    this.toPosition(0, duration);
  },

  // Smooth scroll to bottom
  toBottom: function(duration = this.defaultDuration) {
    const maxScroll = document.documentElement.scrollHeight - window.innerHeight;
    this.toPosition(maxScroll, duration);
  },

  // Scroll to specific pixel position
  toPosition: function(position, duration = this.defaultDuration) {
    const start = window.pageYOffset;
    const distance = position - start;
    const startTime = performance.now();

    function animation(currentTime) {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      
      // Easing function (ease-out)
      const ease = 1 - Math.pow(1 - progress, 3);
      
      window.scrollTo(0, start + (distance * ease));
      
      if (progress < 1) {
        requestAnimationFrame(animation);
      }
    }
    
    requestAnimationFrame(animation);
  },

  // Scroll to element by ID or class selector
  toElement: function(selector, duration = this.defaultDuration, offset = 0) {
    const element = document.querySelector(selector);
    if (!element) {
      console.warn('CustomScroll: Element not found:', selector);
      return;
    }
    
    const elementTop = element.offsetTop + offset;
    this.toPosition(elementTop, duration);
  },

  // Get current scroll position
  getCurrentPosition: function() {
    return window.pageYOffset || document.documentElement.scrollTop;
  },

  // Check if at top
  isAtTop: function() {
    return this.getCurrentPosition() <= 10; // 10px tolerance
  },

  // Check if at bottom
  isAtBottom: function() {
    const scrollTop = this.getCurrentPosition();
    const windowHeight = window.innerHeight;
    const documentHeight = document.documentElement.scrollHeight;
    
    return scrollTop + windowHeight >= documentHeight - 10; // 10px tolerance
  },

  // Set default duration for all animations
  setDefaultDuration: function(duration) {
    this.defaultDuration = duration;
  }
};