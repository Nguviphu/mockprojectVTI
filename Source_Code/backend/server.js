const express = require('express');
const app = express();
const port = process.env.PORT || 8000;

app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'success', 
    message: 'Backend is running and connected to DB: ' + (process.env.DB_HOST || 'localhost')
  });
});

app.listen(port, () => {
  console.log(`Backend API listening on port ${port}`);
});