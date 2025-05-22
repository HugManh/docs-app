import Link from 'next/link';
import { getAllSlugs } from '@/lib/posts';

export default function Home() {
  const slugs = getAllSlugs();

  return (
    <main className='p-8'>
      <h1 className='text-3xl font-bold mb-6'>📚 Danh sách Markdown</h1>
      <ul className='list-disc pl-6 space-y-2'>
        {slugs.map((slug) => {
          const clean = slug.replace('.md', '');
          return (
            <li key={slug}>
              <Link
                className='text-blue-600 hover:underline'
                href={`/posts/${clean}`}
              >
                {clean}
              </Link>
            </li>
          );
        })}
      </ul>
    </main>
  );
}
