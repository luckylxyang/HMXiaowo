import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { httpGet } from '../../utils/HttpUtil'
import Article from '../Article'
import CommonList from '../Component/CommonList'
import Toolbar from '../Component/Toolbar'
import { Api } from '../net/ApiConstants'

@Entry
@Component
export default struct CourseCataloguePage {
  @State data: Array<Article> = []
  private course: any
  private pageIndex: number = 0

  aboutToAppear() {
    this.course = router.getParams()
    this.getData()
  }

  getData() {
    httpGet(Api.baseURL + `article/list/${this.pageIndex}/json?cid=${this.course.id}&order_type=1`, (data: any) => {
      let od: Article[] = data.datas.map((it: any) => new Article(it))
      if (this.pageIndex == 0) {
        this.data = od
      } else {
        this.data.push(...od)
      }
      this.pageIndex++
    }, (error) => {
      hilog.error(0x223, "coursePage", error)
    })
  }

  build() {
    Column() {
      Toolbar({ title: this.course.name })
      CommonList({
        data: this.data,
        listItem: (item, index) => this.getListItem(item, index),
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
            this.pageIndex = 0
            this.getData()
            setTimeout(() => {
              resolve('刷新成功');
            }, 2000);
          });
        },
        onLoadMore: ()=>{
          return new Promise<string>((resolve, reject) => {
            // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
            this.getData()
            setTimeout(() => {
              resolve("");
            }, 2000);
          });
        }
      }).layoutWeight(1)
        .margin({ top: 5, bottom: 5 })
    }.height('100%')
  }

  @Builder
  getListItem(item, index) {
    Text(`${index + 1}、${item.title}`)
      .fontColor($r('app.color.blue'))
      .fontSize(16)
      .width('100%')
      .margin({ right: 12, left: 12 })
      .onClick(ev => {
        router.pushUrl({ url: "pages/DetailPage", params: item })
      })
  }
}