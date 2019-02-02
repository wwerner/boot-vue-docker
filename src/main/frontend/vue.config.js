module.exports = {
  devServer: {
    port: 8081,
    proxy: "http://localhost:8080/"
  }
};
