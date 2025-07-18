/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./web/**/*.{html,js,dart}",
    "./lib/**/*.dart",
    "./bin/**/*.dart"
  ],
  theme: {
    extend: {
      colors: {
        // Custom CSS variable-based colors that adapt to light/dark mode
        'bg-primary': 'var(--bg-primary)',
        'bg-secondary': 'var(--bg-secondary)',
        'bg-card': 'var(--bg-card)',
        'text-primary': 'var(--text-primary)',
        'text-secondary': 'var(--text-secondary)',
        'accent-purple': 'var(--accent-purple)',
        'accent-purple-hover': 'var(--accent-purple-hover)',
        'border-color': 'var(--border-color)',
        
        // Enhanced purple variations
        purple: {
          50: '#faf5ff',
          100: '#f3e8ff',
          200: '#e9d5ff',
          300: '#d8b4fe',
          400: '#c084fc',
          500: '#a855f7',
          600: '#9333ea',
          700: '#7c3aed',
          800: '#6b21a8',
          900: '#581c87',
          950: '#3b0764',
        },
        
        // Enhanced gray scale for better light/dark mode support
        gray: {
          50: '#f9fafb',
          100: '#f3f4f6',
          200: '#e5e7eb',
          300: '#d1d5db',
          400: '#9ca3af',
          500: '#6b7280',
          600: '#4b5563',
          700: '#374151',
          800: '#1f2937',
          900: '#111827',
          950: '#0a0a0a',
        },
        
        // Light mode specific colors
        light: {
          bg: '#ffffff',
          surface: '#f8fafc',
          border: '#e2e8f0',
          text: '#1e293b',
          'text-secondary': '#64748b',
        },
        
        // Dark mode specific colors
        dark: {
          bg: '#0a0a0a',
          surface: '#1f1f1f',
          border: '#333333',
          text: '#ffffff',
          'text-secondary': '#b0b0b0',
        }
      },
      
      fontFamily: {
        'sans': ['Segoe UI', 'Tahoma', 'Geneva', 'Verdana', 'sans-serif'],
      },
      
      fontSize: {
        'hero': ['3.5rem', { lineHeight: '1.2' }],
        'hero-lg': ['4rem', { lineHeight: '1.1' }],
        'hero-subtitle': ['1.8rem', { lineHeight: '1.4' }],
      },
      
      spacing: {
        '18': '4.5rem',
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
      },
      
      borderRadius: {
        'xl': '1rem',
        '2xl': '1.5rem',
        '3xl': '2rem',
      },
      
      boxShadow: {
        'purple': '0 4px 15px rgba(139, 92, 246, 0.3)',
        'purple-lg': '0 8px 25px rgba(139, 92, 246, 0.4)',
        'purple-glow': '0 0 50px rgba(139, 92, 246, 0.3)',
        'card': '0 15px 35px rgba(139, 92, 246, 0.1)',
        'card-light': '0 4px 6px rgba(0, 0, 0, 0.05), 0 1px 3px rgba(0, 0, 0, 0.1)',
        'card-light-lg': '0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05)',
        'card-dark': '0 4px 6px rgba(139, 92, 246, 0.1), 0 1px 3px rgba(139, 92, 246, 0.05)',
        'card-dark-lg': '0 15px 35px rgba(139, 92, 246, 0.1)',
      },
      
      backgroundImage: {
        'gradient-primary': 'linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%)',
        'gradient-bg-light': 'linear-gradient(135deg, rgba(139, 92, 246, 0.05) 0%, rgba(167, 139, 250, 0.03) 100%)',
        'gradient-bg-dark': 'linear-gradient(135deg, rgba(139, 92, 246, 0.1) 0%, rgba(167, 139, 250, 0.05) 100%)',
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic': 'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
        'pattern-light': 'radial-gradient(circle at 25% 25%, rgba(139, 92, 246, 0.03) 0%, transparent 50%), radial-gradient(circle at 75% 75%, rgba(167, 139, 250, 0.015) 0%, transparent 50%)',
        'pattern-dark': 'radial-gradient(circle at 25% 25%, rgba(139, 92, 246, 0.1) 0%, transparent 50%), radial-gradient(circle at 75% 75%, rgba(167, 139, 250, 0.05) 0%, transparent 50%)',
      },
      
      animation: {
        'float': 'float 3s ease-in-out infinite',
        'fade-in-up': 'fadeInUp 1s ease-out',
        'fade-in-down': 'fadeInDown 1s ease-out',
        'slide-in-left': 'slideInLeft 0.8s ease-out',
        'slide-in-right': 'slideInRight 0.8s ease-out',
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'theme-transition': 'themeTransition 0.3s ease',
      },
      
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-10px)' },
        },
        fadeInUp: {
          '0%': {
            opacity: '0',
            transform: 'translateY(30px)',
          },
          '100%': {
            opacity: '1',
            transform: 'translateY(0)',
          },
        },
        fadeInDown: {
          '0%': {
            opacity: '0',
            transform: 'translateY(-30px)',
          },
          '100%': {
            opacity: '1',
            transform: 'translateY(0)',
          },
        },
        slideInLeft: {
          '0%': {
            opacity: '0',
            transform: 'translateX(-30px)',
          },
          '100%': {
            opacity: '1',
            transform: 'translateX(0)',
          },
        },
        slideInRight: {
          '0%': {
            opacity: '0',
            transform: 'translateX(30px)',
          },
          '100%': {
            opacity: '1',
            transform: 'translateX(0)',
          },
        },
        themeTransition: {
          '0%': { opacity: '0.8' },
          '100%': { opacity: '1' },
        },
      },
      
      backdropBlur: {
        xs: '2px',
      },
      
      transitionProperty: {
        'height': 'height',
        'spacing': 'margin, padding',
      },
      
      screens: {
        'xs': '475px',
        '3xl': '1600px',
      },
      
      maxWidth: {
        '8xl': '88rem',
        '9xl': '96rem',
      },
      
      zIndex: {
        '60': '60',
        '70': '70',
        '80': '80',
        '90': '90',
        '100': '100',
      },
    },
  },
  plugins: [
    // Custom plugin for additional utilities
    function({ addUtilities, addComponents, theme }) {
      const newUtilities = {
        '.gradient-text': {
          background: theme('backgroundImage.gradient-primary'),
          '-webkit-background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
          'background-clip': 'text',
        },
        '.glass-effect': {
          'backdrop-filter': 'blur(10px)',
          '-webkit-backdrop-filter': 'blur(10px)',
        },
        '.glass-effect-light': {
          'background': 'rgba(255, 255, 255, 0.95)',
          'backdrop-filter': 'blur(10px)',
          '-webkit-backdrop-filter': 'blur(10px)',
        },
        '.glass-effect-dark': {
          'background': 'rgba(26, 26, 26, 0.95)',
          'backdrop-filter': 'blur(10px)',
          '-webkit-backdrop-filter': 'blur(10px)',
        },
        '.scrollbar-hide': {
          '-ms-overflow-style': 'none',
          'scrollbar-width': 'none',
          '&::-webkit-scrollbar': {
            display: 'none',
          },
        },
        '.theme-transition': {
          'transition': 'background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease',
        },
        '.bg-pattern-light': {
          'background-image': theme('backgroundImage.pattern-light'),
        },
        '.bg-pattern-dark': {
          'background-image': theme('backgroundImage.pattern-dark'),
        },
      }
      
      const newComponents = {
        '.theme-toggle-button': {
          '@apply p-3 rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition-all duration-300 border border-gray-200 dark:border-gray-700 shadow-sm hover:shadow-md': {},
        },
        '.card-theme': {
          '@apply bg-white dark:bg-gray-800 border-gray-200 dark:border-gray-700 theme-transition': {},
        },
        '.text-theme-primary': {
          '@apply text-gray-900 dark:text-white theme-transition': {},
        },
        '.text-theme-secondary': {
          '@apply text-gray-700 dark:text-gray-400 theme-transition': {},
        },
        '.nav-theme': {
          '@apply bg-white/95 dark:bg-gray-900/95 border-gray-200 dark:border-gray-700 theme-transition': {},
        },
      }
      
      addUtilities(newUtilities, ['responsive', 'hover', 'dark'])
      addComponents(newComponents)
    },
  ],
  
  // Dark mode configuration
  darkMode: 'class',
  
  // Prefix for all Tailwind classes (optional)
  // prefix: 'tw-',
  
  // Important modifier (use with caution)
  // important: true,
  
  // Separator for variant prefixes
  separator: ':',
  
  // Core plugins configuration
  corePlugins: {
    // Disable preflight if you want to keep your existing CSS reset
    // preflight: false,
    
    // You can disable specific core plugins here if needed
    // container: false,
  },
}