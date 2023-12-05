import BannerDataSource from './BannerDataSource'
import { httpGet } from '../../utils/HttpUtil'
import axios from '../../utils/axios'
import Banner from './Banner'
import Article from '../Article'
import { dateFormat } from '../../utils/CommonUtils'
import router from '@ohos.router';
import promptAction from '@ohos.promptAction'

@Preview
@Component
export default struct HomePage {
  private swiperController: SwiperController = new SwiperController()
  @State private banners: BannerDataSource = new BannerDataSource([])
  @State private articleList: Article[] = []
  private pageIndex = 0

  aboutToAppear(): void {
    this.getBanner()
    this.getHomeArticle(this.pageIndex)
  }

  getBanner() {
    let url = 'https://www.wanandroid.com/banner/json'
    let _ = this
    httpGet(url, (data: any) => {
      _.banners.addData(data)
    }, (error) => {
      console.info(error)
    })
  }

  getHomeArticle(pageIndex: number) {
    let url = `https://www.wanandroid.com/article/list/${pageIndex}/json`
    let _ = this
    // httpGet(url, (data: any) => {
    //   let od: Article[] = data.datas.map((it: any) => new Article(it))
    //   _.articleList.push(...od)
    // }, (error) => {
    //   console.info(error)
    // })

    axios.get(`article/list/${pageIndex}/json`)
      .then((data: any) => {
        let od: Article[] = data.datas.map((it: any) => new Article(it))
        _.articleList.push(...od)
      }).catch(err => {
        console.error(err)
    })

  }

  build() {
    Column() {

      Swiper(this.swiperController) {
        LazyForEach(this.banners, (item: any) => {
          Stack({ alignContent: Alignment.Bottom }) {
            Image(item.imagePath)
              .alt($r('app.media.home'))
              .width('100%').height('100%')
          }.width('99%').height(160)

        }, item => item)
      }
      .cachedCount(2)
      .index(1)
      .autoPlay(true)
      .interval(2000)
      .indicator(true)
      .loop(true)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        console.info(index.toString())
      })

      List() {
        ForEach(this.articleList, (item: Article, index) => {
          ListItem() {
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
      }.width('100%')
      .divider({
        strokeWidth: 1,
        startMargin: 60,
        endMargin: 10,
        color: '#ffe9f0f0'
      })
    }
  }
}