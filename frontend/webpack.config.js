const path                        = require('path');
const webpack                     = require('webpack');
const { VueLoaderPlugin }         = require('vue-loader');
const HtmlWebpackPlugin           = require('html-webpack-plugin');
const FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin');

const EnvConfig = {
  development: {
    api_url: 'http://localhost:3000',
    amplitude_api_key: '7c92416d3c8102b79c6b0a54ebad48bf',
  },
  production: {
    api_url: 'http://167.99.130.51:3000',
    amplitude_api_key: '7c92416d3c8102b79c6b0a54ebad48bf',
  }
};

module.exports = (env = {}) => ({
  mode: env.NODE_ENV === 'production' ? 'production' : 'development',
  devtool: env.prod ? 'source-map' : 'cheap-module-eval-source-map',
  entry: path.resolve(__dirname, 'src/index.ts'),
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: "index.js",
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
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, 'index.html'),
    }),
    new FriendlyErrorsWebpackPlugin(),
    new webpack.DefinePlugin({
      API_URL: JSON.stringify(EnvConfig[env.NODE_ENV].api_url),
      AMPLITUDE_API_KEY: JSON.stringify(EnvConfig[env.NODE_ENV].amplitude_api_key),
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
