

export default class Article {
  adminAdd: boolean;
  apkLink: string;
  audit: number;
  author: string;
  canEdit: boolean;
  chapterId: number;
  chapterName: string;
  collect: boolean;
  courseId: number;
  desc: string;
  descMd: string;
  envelopePic: string;
  fresh: boolean;
  host: string;
  id: number;
  isAdminAdd: boolean;
  link: string;
  niceDate: string;
  niceShareDate: string;
  origin: string;
  prefix: string;
  projectLink: string;
  publishTime: number;
  realSuperChapterId: number;
  selfVisible: number;
  shareDate: number;
  shareUser: string;
  superChapterId: number;
  superChapterName: string;
  tags: string[]; // 根据实际情况定义标签的类型
  title: string;
  type: number;
  userId: number;
  visible: number;
  zan: number;

  constructor(data: Partial<Article>) {
    // 使用 Partial 来允许传入的数据不完整，只需要包含部分属性即可
    Object.assign(this, data);
  }
}