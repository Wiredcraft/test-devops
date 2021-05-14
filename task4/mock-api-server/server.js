const express = require('express');
const { uid } = require('uid');

const port = 3000;

const app = express();

app.use(express.json());

let users = [];

app.get('/api/users', (req, res) => {
  res.json({ users: users });
});

app.post('/api/users', (req, res) => {
  const user = { ...req.body, id: uid() };
  users.push(user);
  res.status(201).json(user);
});

app.get('/api/user/:id', (req, res) => {
  const id = req.params.id;
  const index = users.findIndex((user) => user.id === id);
  if (index === -1) {
    res.status(404).send({ status: 'not found' });
    return;
  }
  res.status(200).json(users[index]);
});

app.put('/api/user/:id', (req, res) => {
  const id = req.params.id;
  const index = users.findIndex((user) => user.id === id);
  if (index === -1) {
    res.status(404).send({ status: 'not found' });
    return;
  }
  users[index] = { ...req.body };
  res.status(200).json(users[index]);
});

app.delete('/api/user/:id', (req, res) => {
  const id = req.params.id;
  const index = users.findIndex((user) => user.id === id);
  if (index === -1) {
    res.status(404).send({ status: 'not found' });
    return;
  }
  const deletedUser = users[index];
  users = users.filter((user) => user.id !== id);
  res.status(200).json(deletedUser);
});

module.exports = app;
