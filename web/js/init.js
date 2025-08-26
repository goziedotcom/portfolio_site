(function () {
  var saved = localStorage.getItem('theme');
  var systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

  // Apply dark class if user prefers dark OR system is dark
  if (saved === 'ThemeMode.dark' ||
    (saved === 'ThemeMode.system' && systemDark) ||
    (!saved && systemDark)) {
    document.documentElement.classList.add('dark');
  }
})();