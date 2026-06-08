import express from "express";

const app = express();
const port = 3000;

app.use(express.json());

app.get("/", (_, res) => {
  res.json({ message: "Express + Bun API 🚀" });
});

app.listen(port, () => {
  console.log(`running on port ${port}`)
});

export default app;