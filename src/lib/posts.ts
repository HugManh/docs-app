import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';

const contentDir = path.join(process.cwd(), 'content');

export function getAllSlugs() {
  return fs.readdirSync(contentDir).filter((file) => file.endsWith('.md'));
}

export function getPost(slug: string) {
  const realSlug = slug.replace(/\.md$/, '');
  const fullPath = path.join(contentDir, `${realSlug}.md`);
  const file = fs.readFileSync(fullPath, 'utf8');
  const { data, content } = matter(file);
  return { slug: realSlug, meta: data, content };
}
