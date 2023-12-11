import { PullToRefresh } from '@ohos/pulltorefresh'

@Component
export default  struct CommonList {
  @Link data : any[]
  @BuilderParam listItem?: (item, index?:number) => void;
  private scroller: Scroller = new Scroller();
  onRefresh?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      setTimeout(() => {
        resolve('刷新失败');
      }, 1000);
    });
  };
  onLoadMore?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      setTimeout(() => {
        resolve('');
      }, 1000);
    });
  };

  build() {
    PullToRefresh({
      data: this.data,
      scroller: this.scroller,
      customList: () => {
        // 一个用@Builder修饰过的UI方法
        this.getListView();
      },
      onRefresh: this.onRefresh,
      // 可选项，上拉加载更多回调
      onLoadMore: this.onLoadMore,
      customLoad: null,
      customRefresh: null,
    })
  }

  @Builder
  private getListView() {
    List({ space: 20, scroller: this.scroller }) {
      ForEach(this.data, (item: any, index) => {
        this.listItem(item, index)
      })
    }
    .divider({ strokeWidth: 1, color: 0x222222 })
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }
}