const app = require('./server');
const supertest = require('supertest');

const user = { name: 'joe', age: 20 };

// Start with an empty users array
test('GET /api/users', async () => {
  await supertest(app)
    .get('/api/users')
    .expect(200)
    .then((res) => {
      expect(Array.isArray(res.body.users)).toBeTruthy();
      expect(res.body.users.length).toEqual(0);
    });
});

// Add new user to that array
test('POST /api/users', async () => {
  await supertest(app)
    .post('/api/users')
    .send(user)
    .expect(201)
    .then((res) => {
      expect(res.body.name).toBe(user.name);
      expect(res.body.age).toBe(user.age);
      // Save the user id for testing in later steps
      user.id = res.body.id;
    });
});

// Test if the user has been added
test('GET /api/user/:id', async () => {
  await supertest(app)
    .get(`/api/user/${user.id}`)
    .expect(200)
    .then((res) => {
      expect(res.body.name).toBe(user.name);
      expect(res.body.age).toBe(user.age);
    });
});

// Test if the array contains that user
test('GET /api/users', async () => {
  await supertest(app)
    .get('/api/users')
    .expect(200)
    .then((res) => {
      expect(Array.isArray(res.body.users)).toBeTruthy();
      expect(res.body.users.length).toEqual(1);
      expect(res.body.users[0].name).toBe(user.name);
      expect(res.body.users[0].age).toBe(user.age);
    });
});

// Update that specific user
test('PUT /api/user/:id', async () => {
  user.age++;
  await supertest(app)
    .put(`/api/user/${user.id}`)
    .send(user)
    .expect(200)
    .then((res) => {
      expect(res.body.name).toBe(user.name);
      expect(res.body.age).toBe(user.age);
    });
});

// Delete that user
test('DELETE /api/user/:id', async () => {
  await supertest(app)
    .delete(`/api/user/${user.id}`)
    .expect(200)
    .then((res) => {
      expect(res.body.name).toBe(user.name);
      expect(res.body.age).toBe(user.age);
    });
});

// Now the users array should be empty again
test('GET /api/users', async () => {
  await supertest(app)
    .get('/api/users')
    .expect(200)
    .then((res) => {
      expect(Array.isArray(res.body.users)).toBeTruthy();
      expect(res.body.users.length).toEqual(0);
    });
});
