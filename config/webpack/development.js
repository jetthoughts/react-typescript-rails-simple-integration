process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

// module.exports = environment.toWebpackConfig()
const webpackConfig = environment.toWebpackConfig()

const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");
const smp = new SpeedMeasurePlugin();
const smpConfig = smp.wrap(webpackConfig)

module.exports = smpConfig
