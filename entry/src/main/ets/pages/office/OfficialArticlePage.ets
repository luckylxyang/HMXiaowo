
import router from '@ohos.router'
import axios from '@ohos/axios'
import { dateFormat } from '../../utils/CommonUtils'
import { httpGet } from '../../utils/HttpUtil'
import LocationUtil from '../../utils/LocationUtil'
import Article from '../Article'
import BannerDataSource from '../home/BannerDataSource'
import { Api } from '../net/ApiConstants'
import { OfficialName } from './OfficialName'
@Component
export default struct OfficialArticlePage {
  @State private banners: BannerDataSource = new BannerDataSource([])
  @State private articleList: Article[] = []
  private pageIndex = 0
  officialCode : number

  aboutToAppear() : void {
    this.getOfficialArticles()
  }


  /**
   * 获取公众号文章列表
   */
  getOfficialArticles() {
    httpGet(Api.baseURL + `wxarticle/list/${this.officialCode}/${this.pageIndex}/json`, (data: any) => {
      let od: Article[] = data.datas.map((it: any) => new Article(it))
      // this.articleList.push(...od)
      this.banners.addData(od)
    }, (error) => {
      console.info(error)
    })
    // axios.get(`wxarticle/list/408/${this.pageIndex}/json`)
    //   .then((data: any) => {
    //     let od: Article[] = data.map((it: any) => new Article(it))
    //     this.articleList.push(...od)
    //   }).catch(err => {
    //   console.error(err)
    // })

  }

  build(){
    Column(){

      List(){
        LazyForEach(this.banners, (item : Article, index)=>{
          ListItem(){
            Row({ space: 8 }) {
              Image(item.collect ? $r('app.media.collect_selected') : $r('app.media.collect'))
                .width(24)
                .height(24)
                .margin(12)
                .onClick(ev => {
                  item.collect = !item.collect
                  this.articleList[index] = {...item}
                })
              Column() {
                Text(item.title)
                  .fontSize(18)
                  .textOverflow({ overflow: TextOverflow.Ellipsis})
                  .width('90%')
                  .maxLines(1)
                  .margin({ bottom: 12 })

                Row() {

                  Text(item.author).fontSize(14)
                  Text(item.superChapterName + "/" + item.chapterName).fontSize(14)
                  Text(dateFormat('YYYY-MM-DD HH:mm', new Date(item.publishTime))).fontSize(14)
                }.justifyContent(FlexAlign.SpaceBetween)
              }.alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .padding({top: 8, bottom: 8})
            .onClick((event) => {
              router.pushUrl({
                url: 'pages/DetailPage', // 目标url
                params: item
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
                console.info('Invoke replaceUrl succeeded.');
              })
            })
          }
        })
      }
    }.width('100%')
  }

}