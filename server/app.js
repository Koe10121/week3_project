const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
const con = require('./db');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const sql = 'SELECT * FROM users WHERE username = ?';
  con.query(sql, [username], (err, result) => {
    if (err) {
      return res.status(500).send('Server error');
    }
    if (result.length !== 1) {
      return res.status(401).send("Wrong username");
    }
    const user = result[0];
    bcrypt.compare(password, user.password, (err, isMatch) => {
      if (err) {
        return res.status(500).send('Server error');
      }
      if (!isMatch) {
        return res.status(401).send("Wrong password");
      }
      return res.json({ userId: user.id, userName: user.username });;
    });
  });
});

app.get('/expenses/:userId', (req, res) => {
  const userId = req.params.userId;
  const sql = 'SELECT * FROM expense WHERE user_id = ?';
  con.query(sql, [userId], (err, result) => {
    if (err) {
      return res.status(500).send('Server error');
    }
    return res.json(result);
  });
});

app.get("/expenses/today/:userId", (req, res) => {
  const { userId } = req.params;
  con.query(
    "SELECT * FROM expense WHERE user_id = ? AND DATE(date) = CURDATE()",
    [userId],
    (err, results) => {
      if (err) return res.status(500).send("DB error");
      res.json(results);
    }
  );
});

app.get('/expenses/search/:userId', (req, res) => {
  const userId = req.params.userId;
  const item = req.query.item;
  const sql = 'SELECT * FROM expense WHERE user_id = ? AND item LIKE ?';
  con.query(sql, [userId, '%${item}%'], (err, result) => {
    if (err) {
      return res.status(500).send('Server error');
    }
    return res.json(result);
  });
});

app.post('/expenses', (req, res) => {
  const { userId, item, paid } = req.body;
  if (!userId || !item || !paid) {
    return res.status(400).send('Missing fields');
  }
  const sql = 'INSERT INTO expense (user_id, item, paid, date) VALUES (?, ?, ?, NOW())';
  con.query(sql, [userId, item, paid], (err, result) => {
    if (err) {
      return res.status(500).send('Server error');
    }
    return res.status(201).send('Inserted!');
  });
});

app.delete('/expenses/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM expense WHERE id = ?';
  con.query(sql, [id], (err, result) => {
    if (err) {
      return res.status(500).send('Server error');
    }
    if (result.affectedRows === 0) {
      return res.status(404).send('Expense not found');
    }
    return res.status(200).send('Expense deleted successfully');
  });
});

app.listen(3000, () => {
  console.log('Server is running');
});