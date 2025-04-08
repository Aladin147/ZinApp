module.exports = function (api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    plugins: [
      // NativeWind plugin removed
      // Keep module resolver for path aliases
      [
        'module-resolver',
        {
          root: ['./'],
          extensions: ['.ios.js', '.android.js', '.js', '.ts', '.tsx', '.json'],
          alias: {
            '@components': './components',
            '@screens': './screens',
            '@constants': './constants',
            '@hooks': './hooks',
            '@assets': './assets',
            '@theme': './theme',
            '@utils': './utils',
            '@types': './types',
            '@services': './services',
            '@navigation': './navigation',
            '@state': './state'
          }
        }
      ],
      'react-native-reanimated/plugin' // Keep reanimated plugin
    ],
  };
};
