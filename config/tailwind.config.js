const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.erb'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Comfortaa', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        success: '#8fba3b',
        dark_green: '#256d36',
        error: '#dc3545',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
