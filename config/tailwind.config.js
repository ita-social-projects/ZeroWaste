const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.erb',
    '!./app/views/account/**/*.erb'
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
        '1530': '1530px',
      },
      spacing: {
        '18': '4.5rem',
        '22': '5.5rem',
        '28': '7rem',
        '30': '7.5rem',
        '36': '9rem',
        '40': '10rem',
        '44': '11rem',
        '48': '12rem',
        '52': '13rem',
        '56': '14rem',
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
