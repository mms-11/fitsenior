import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import meRoutes from './src/routes/me.js';
import demandsRoutes from './src/routes/demands.js';
import classesRoutes from './src/routes/classes.js';
import enrollmentsRoutes from './src/routes/enrollments.js';
import forumRoutes from './src/routes/forum.js';
import messagesRoutes from './src/routes/messages.js';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok', uptime: process.uptime() });
});

// Prefixo /api pra tudo
app.use('/api', meRoutes);
app.use('/api', demandsRoutes);
app.use('/api', classesRoutes);
app.use('/api', enrollmentsRoutes);
app.use('/api', forumRoutes);
app.use('/api', messagesRoutes);

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Backend rodando na porta ${port}`);
});
