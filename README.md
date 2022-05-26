# StockTaxSavingApp

<a href="https://apps.apple.com/us/app/stocktaxsaver/id1622345021?itsct=apps_box_badge&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-radius: 13px; width: 250px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1653004800&h=9f7c32c78d33ad97fe5d349b47f939e1" alt="Download on the App Store" style="border-radius: 13px; width: 250px; height: 83px;"></a>

해외주식을 팔아 발생한 수익의 약 22% 정도의 세금을 내야 합니다. 하지만 그 중 매년 250만원의 세금이 공제됩니다. 따라서 가장 유리한 절세 방법은 차익을 250만원에 맞추는 것입니다.
2021년 연말에 250만원의 차익을 맞추기 위해 가지고있는 주식을 매도하려고 했을때 어떤 주식을 얼마나 팔아야 가장 250만원에 가까울지 계산하는데 제법 긴 시간이 걸렸고 번거로웠습니다.
저 뿐만 아니라 해외주식을 보유하신 분들이 한결 수월하게 계산하실 수 있게 도움을 드릴 수 있는 앱을 만들기로 마음먹었습니다.

https://user-images.githubusercontent.com/31836577/170402971-344ce6df-1aef-4d39-9249-d159f2f146d4.mov

## 사용한 기술 스택

1. 디자인 패턴 MVVM

디자인 패턴은 MVVM 을 사용했습니다. 컨트롤러 안에 모든 로직을 다 집어넣는거 보다 뷰만 담당하게끔 하고 ViewModel 에서 네트워킹, 계산, 저장 등 뷰와 관계없는 업무를 수행하게 했습니다. 

2. RxSwift RxCocoa

ViewModel은 뷰를 건드리지 않고 컨트롤러는 모델에 직접 접근하지 않기 때문에 ViewModel과 Controller 를 bind 해줘야합니다. 다양한 방법들이 존재하지만 이 프로젝트에선 많은 사람들이 즐겨쓰는 RxSwift 라이브러리를 이용해 바인딩을 구현했습니다. 

3. AutoLayout

스토리보드는 일체 사용하지 않고 코드로만 UI를 구현했습니다. Autolayout을 이용해 View 간의 관계를 설립했고 다양한 변경에 responsive 하게 레이아웃 될 수 있게 만들었습니다. 

