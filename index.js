import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default function(robot, scripts) {
  const scriptsPath = path.resolve(__dirname, 'src');
  if (fs.existsSync(scriptsPath)) {
    for (const script of fs.readdirSync(scriptsPath)) {
      if (scripts != null && !scripts.includes('*')) {
        if (scripts.includes(script)) {
          robot.loadFile(scriptsPath, script);
        }
      } else {
        robot.loadFile(scriptsPath, script);
      }
    }
  }
}
