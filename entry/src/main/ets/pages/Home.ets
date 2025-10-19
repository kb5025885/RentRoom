import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import Ad from '../views/Home/Ad';
import RoomRecommend from '../views/Home/RoomRecommend';

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';
import { PADDING } from '../constants/size';

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource();
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    this.bannerList.setList(homeData.bannerList);
    this.navList = homeData.navList;
    this.tileList = homeData.tileList;
    this.planList = homeData.planList;
    this.adPicture = homeData.adPicture;
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          SwiperLayout({ bannerList: this.bannerList })

          Column() {
            NavList({ navList: this.navList })
            TileList({ tileList: this.tileList })
            PlanList({ planList: this.planList })
            Ad({ adPicture: this.adPicture })
          }.padding({ left: PADDING, right: PADDING })

          RoomRecommend()
        }
        .justifyContent(FlexAlign.Start)
      }
      .height('100%')
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)

      SearchBar()
    }
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}