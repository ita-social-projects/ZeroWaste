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
        nunito: ['Nunito', 'sans-serif'],
      },
      colors: {
        success: '#8fba3b',
        color: '#fff',
        error: '#9e1503',
        gray: '#8d8d8d',
        matte_lime_green: '#73952f',
        light_gray: '#ececec',
        basic_gray: '#b3b3b3',
        grey: '#999999',
        dark_gray: '#515151',
        dark_green: '#256d36',
        white: '#ffffff',
        blue: '#007bff',
        dark_blue: '#0069d9',
      },
      minWidth: {
        '36': '36px',
      },
      maxWidth: {
        '1230': '1230px',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
