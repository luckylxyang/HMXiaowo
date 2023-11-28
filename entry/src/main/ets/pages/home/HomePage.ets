import BannerDataSource from './BannerDataSource'
import httpGet from '../../utils/HttpUtil'
import Banner from './Banner'
import Article from '../Article'
import { dateFormat } from '../../utils/CommonUtils'
import router from '@ohos.router';

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
    httpGet(url, (data: any) => {
      let od: Article[] = data.datas.map((it: any) => new Article(it))
      _.articleList.push(...od)
    }, (error) => {
      console.info(error)
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
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            Row({ space: 8 }) {
              Image($r('app.media.collect'))
                .width(24)
                .height(24)
                .margin(12)
              Column() {
                Text(item.title)

                Row() {

                  Text(item.author)
                  Text(item.superChapterName + "/" + item.chapterName)
                  Text(dateFormat('YYYY-MM-DD HH:mm', new Date(item.publishTime)))
                }
              }
            }
            .width('95%')
            .backgroundColor('#FFFFFF')
            .justifyContent(FlexAlign.Center)
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
    }
  }
}