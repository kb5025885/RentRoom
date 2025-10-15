import Home from './Home';
import See from './See';
import Service from './Service';
import Discover from './Discover';
import My from './My';

@Entry
@Component
struct Index {

  // 当前 tab 高亮的下标
  @State currentIndex: number = 0;

  // 生成 tab 的函数
  @Builder TabBuilder(index: number, text: string, icon: Resource, activeIcon: Resource) {
    Column() {
      // 项目中常用的颜色、大小等会定义成常量，将来方便复用和统一调整。而不常用的大小颜色就不需要定义了，直接写死即可。
      Image(this.currentIndex === index ? activeIcon : icon).width(28)
      Text(text).fontSize(10).fontColor(this.currentIndex === index ? $r('app.color.black') : '#a0a0a0').height(15)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
        TabContent() {
          Home()
        }.tabBar(this.TabBuilder(0, '首页', $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

        TabContent() {
          See()
        }.tabBar(this.TabBuilder(1, '想看', $r('app.media.tabbar_see'), $r('app.media.tabbar_see_active')))

        TabContent() {
          Service()
        }.tabBar(this.TabBuilder(2, '服务', $r('app.media.tabbar_service'), $r('app.media.tabbar_service_active')))

        TabContent() {
          Discover()
        }.tabBar(this.TabBuilder(3, '发现', $r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active')))

        TabContent() {
          My()
        }.tabBar(this.TabBuilder(4, '我的', $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .barHeight(50) // 设置 tab 导航栏的高度，默认 56
      .scrollable(false) // 禁止左右滑动切换tab
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.white'))
    }.height('100%')
  }
}




// @Entry
// @Component
// struct Index {
//   @State message: string = 'Hello World';
//
//   build() {
//     RelativeContainer() {
//       Text(this.message)
//         .id('HelloWorld')
//         .fontSize($r('app.float.page_text_font_size'))
//         .fontWeight(FontWeight.Bold)
//         .alignRules({
//           center: { anchor: '__container__', align: VerticalAlign.Center },
//           middle: { anchor: '__container__', align: HorizontalAlign.Center }
//         })
//         .onClick(() => {
//           this.message = 'Welcome';
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
// }