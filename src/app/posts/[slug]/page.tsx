import { getPost } from '@/lib/posts';
import { remark } from 'remark';
import html from 'remark-html';

type Props = { params: { slug: string } };

export default async function PostPage({ params }: Props) {
  const { content, meta } = getPost(params.slug);
  const processed = await remark().use(html).process(content);
  const contentHtml = processed.toString();

  return (
    <main className='p-8'>
      <h1 className='text-3xl font-bold mb-4'>{meta.title || params.slug}</h1>
      <article
        className='prose'
        dangerouslySetInnerHTML={{ __html: contentHtml }}
      />
    </main>
  );
}
