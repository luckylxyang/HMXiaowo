import hilog from '@ohos.hilog'
import router from '@ohos.router'
import axios from '../../utils/axios'
import { httpGet } from '../../utils/HttpUtil'
import Article from '../Article'
import CommonList from '../Component/CommonList'
import { Api } from '../net/ApiConstants'

@Component
export default struct CoursePage {
  @State data: Array<Article> = []

  aboutToAppear() {
    this.getData()
  }

  getData() {
    httpGet(Api.baseURL + `chapter/547/sublist/json`, (data: any) => {
      let od: Article[] = data.map((it: any) => new Article(it))
      this.data = od
    }, (error) => {
      hilog.error(0x223, "coursePage", error)
    })
  }

  build() {
    Stack() {
      CommonList({
        data: this.data,
        listItem: (item) => this.getListItem(item),
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
            this.getData()
            setTimeout(() => {
              resolve('刷新成功');
            }, 2000);
          });
        }
      }).height('100%')
    }.height('100%')
  }

  @Builder
  getListItem(item) {
    Row() {
      Image(item.cover)
        .width(100)
        .height(150)
        .margin(6)

      Column() {
        Text(item.name)
          .fontColor($r('app.color.blue'))
          .fontSize(16)
          .margin({ bottom: 4 })
        Text(`作者：${item.author}`)
          .fontSize(14)
          .margin({ bottom: 4 })
        Text(item.desc)
          .fontSize(14)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(4)
      }.alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ right: 12 })
    }.onClick(ev => {
      router.pushUrl({ url: "pages/course/CourseCataloguePage", params: item })
    })
    .width('100%')
    .margin({ right: 12, left: 12 })
  }
}