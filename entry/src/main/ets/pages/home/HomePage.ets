import BannerDataSource from './BannerDataSource'
import  httpGet from '../../utils/HttpUtil'
import Banner from './Banner'

@Preview
@Component
export default struct  HomePage{

  private swiperController: SwiperController = new SwiperController()
  private data: BannerDataSource = new BannerDataSource([])

  aboutToAppear(): void {
    let url = 'https://www.wanandroid.com/banner/json'
    let _ = this
    // httpGet(url, (data : any)=>{
    //
    //   _.data = new BannerDataSource(data)
    // }, (error)=>{
    //   console.log(error)
    // })
  }

  build(){
    Column(){

      Swiper(this.swiperController) {
        LazyForEach(this.data, (item: Banner) => {
          Stack({ alignContent: Alignment.Bottom }){
            Image(item.getImagePath()).width('100%').height('100%')
            Text(item.getTitle())
          }.width('90%').height(160)
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
    }
  }

}