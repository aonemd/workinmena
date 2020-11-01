const path                        = require('path');
const webpack                     = require('webpack');
const { VueLoaderPlugin }         = require('vue-loader');
const FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin');

let environment = process.env.NODE_ENV === 'production' ? 'production' : 'development';
const EnvConfig = {
  development: {
    api_url: 'http://localhost:3000',
    amplitude_api_key: '7c92416d3c8102b79c6b0a54ebad48bf',
  },
  production: {
    api_url: 'http://localhost:3000',
    amplitude_api_key: '7c92416d3c8102b79c6b0a54ebad48bf',
  }
};

module.exports = (env = {}) => ({
  mode: env.prod ? 'production' : 'development',
  devtool: env.prod ? 'source-map' : 'cheap-module-eval-source-map',
  entry: path.resolve(__dirname, 'src/index.ts'),
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: "index.js",
    publicPath: 'dist/'
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        use: 'vue-loader'
      },
      {
        test: /\.ts$/,
        loader: 'ts-loader',
        options: {
          appendTsSuffixTo: [/\.vue$/],
        }
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader',
            options: { importLoaders: 1 }
          },
          {
            loader: 'postcss-loader',
          },
        ]
      },
    ]
  },
  resolve: {
    extensions: ['.ts', '.js', '.vue', '.json'],
    alias: {
      'vue': '@vue/runtime-dom'
    }
  },
  plugins: [
    new VueLoaderPlugin(),
    new FriendlyErrorsWebpackPlugin(),
    new webpack.DefinePlugin({
      API_URL: JSON.stringify(EnvConfig[environment].api_url),
      AMPLITUDE_API_KEY: JSON.stringify(EnvConfig[environment].amplitude_api_key),
    }),
  ],
  devServer: {
    inline: true,
    hot: true,
    stats: 'minimal',
    contentBase: __dirname,
    overlay: true,
    historyApiFallback: true,
  }
})
