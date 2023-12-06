
import Article from '../Article';
export class OfficialName {
  articleList: Article[]; // 根据实际情况定义 articleList 的类型
  author: string;
  children: OfficialName[];
  courseId: number;
  cover: string;
  desc: string;
  id: number;
  lisense: string;
  lisenseLink: string;
  name: string;
  order: number;
  parentChapterId: number;
  type: number;
  userControlSetTop: boolean;
  visible: number;

  constructor(data: Partial<OfficialName>) {
    Object.assign(this, data);
  }
}