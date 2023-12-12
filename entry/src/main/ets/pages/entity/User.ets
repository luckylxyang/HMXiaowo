class User {
  admin: boolean;
  chapterTops: number[]; // 根据实际情况定义 chapterTops 的类型
  coinCount: number;
  collectIds: number[];
  email: string;
  icon: string;
  id: number;
  nickname: string;
  password: string;
  publicName: string;
  token: string;
  type: number;
  username: string;

  constructor(data: Partial<User>) {
    Object.assign(this, data);
  }
}