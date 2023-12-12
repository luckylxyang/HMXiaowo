

export default class Banner {
  private desc: string;
  private id: number;
  private imagePath: string;
  private visible: number;
  private order: number;
  private title: string;
  private type: number;
  private url: string;

  constructor(data: {
    desc: string;
    id: number;
    imagePath: string;
    isVisible: number;
    order: number;
    title: string;
    type: number;
    url: string;
  }) {
    this.desc = data.desc;
    this.id = data.id;
    this.imagePath = data.imagePath;
    this.visible = data.isVisible;
    this.order = data.order;
    this.title = data.title;
    this.type = data.type;
    this.url = data.url;
  }

  // Getter方法
  getDesc(): string {
    return this.desc;
  }

  getId(): number {
    return this.id;
  }

  getImagePath(): string {
    return this.imagePath;
  }

  isVisible(): number {
    return this.visible;
  }

  getOrder(): number {
    return this.order;
  }

  getTitle(): string {
    return this.title;
  }

  getType(): number {
    return this.type;
  }

  getUrl(): string {
    return this.url;
  }
}