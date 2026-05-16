const express = require("express");
const client = require("prom-client");

const app = express();
const PORT = 3001;

client.collectDefaultMetrics();

const httpRequestCounter = new client.Counter({
  name: "http_requests_total",
  help: "Total HTTP Requests"
});

app.use((req, res, next) => {
  httpRequestCounter.inc();
  next();
});

app.get("/", (req, res) => {
  res.send("Node App Running!");
});

app.get("/metrics", async (req, res) => {
  res.set("Content-Type", client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});