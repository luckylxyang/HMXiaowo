
import axios from '../../utils/axios'
import OfficialArticlePage from './OfficialArticlePage'
import { OfficialName } from './OfficialName'
@Component
export default struct OfficePage {
  @State private tabList: OfficialName[] = []

  aboutToAppear() : void {
    this.getOfficialTabs()
  }


  /**
   * 获取公众号列表
   */
  getOfficialTabs() {
    let _ = this
    axios.get(`wxarticle/chapters/json`)
      .then((data: any) => {
        let od: OfficialName[] = data.map((it: any) => new OfficialName(it))
        _.tabList.push(...od)
      }).catch(err => {
      console.error(err)
    })

  }

  build(){
    Stack(){
      Tabs({ barPosition: BarPosition.Start }){
        ForEach(this.tabList, (item : OfficialName, index)=>{
          TabContent(){
            OfficialArticlePage({ officialCode: item.id})
              .width('100%')
              .height('100%')
            // Text(item.name)
          }.tabBar(item.name)
        })
      }.barMode(BarMode.Scrollable)
    }.width('100%')
  }

}