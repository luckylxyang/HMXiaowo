
import List from '@ohos.util.List'
import ArrayList from '@ohos.util.ArrayList'
import Banner from './Banner'
export default class BannerDataSource implements IDataSource {
  private list: Banner[] = []
  private listener: DataChangeListener

  constructor(list: Banner[]) {
    this.list = list
  }

  addData(list : Banner[]){
    this.list.push(...list)
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): Banner {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}