const { env, webpackConfig } = require('shakapacker')
const { existsSync } = require('fs')
const { resolve } = require('path')

const envSpecificConfig = () => {
  const path = resolve(__dirname, `${env.nodeEnv}.js`)
  if (existsSync(path)) {
    console.log(`Loading ENV specific webpack configuration file ${path}`)
    return require(path)
  } else {                       
    throw new Error(`Got Error with NODE_ENV = ${env.nodeEnv}`);
  }
}

module.exports = envSpecificConfig()
