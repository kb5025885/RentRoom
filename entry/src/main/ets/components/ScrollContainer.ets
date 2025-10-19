import { IColor } from '../models/HomeData';

@Component
export default struct ScrollContainer {
  @BuilderParam contentBuilder: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'

  @Builder
  defaultBuilder() {
  }

  // 处理滚动
  handleScroll = (xOffset: number, yOffset: number) => {
    // 更新并修正 scrollY 的值
    this.scrollY += yOffset;
    if (this.scrollY < 0) {
      this.scrollY = 0;
    }
    this.calcColor()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY < 10) {
      // 初始状态
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
    } else if (this.scrollY < 100) {
      // 渐变状态
      const colorOpacity = (this.scrollY - 10) / (100 - 10)
      this.bgColor = `rgba(255, 255, 255, ${colorOpacity})`
      this.fontColor = `rgba(0, 0, 0, ${colorOpacity})`
    } else {
      // 结束状态
      this.bgColor = 'rgb(255, 255, 255)'
      this.fontColor = 'rgb(0, 0, 0)'
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          // 渲染内容
          this.contentBuilder()
        }
        .width('100%')
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .backgroundColor($r('app.color.bg_gray_second'))
      .onDidScroll(this.handleScroll)

      Column() {
        // 渲染头部导航
        // 按引用传递
        this.navBuilder({ fontColor: this.fontColor, bgColor: this.bgColor })
      }.backgroundColor(this.bgColor)

    }.height('100%').alignContent(Alignment.TopStart)
  }
}