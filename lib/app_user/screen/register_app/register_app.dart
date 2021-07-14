import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/utils/rules_app.dart';
import 'service_app/service_app.dart';

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký app"),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(1),
                Theme.of(context).primaryColor.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4],
              tileMode: TileMode.clamp),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      width: Get.width,
                      height: 350,
                      child: Image.asset("assets/images/Pattern Success.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child:
                          Image.asset("assets/images/register_app_image.png"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "ĐIỀU KHOẢN",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color!),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Chào mừng bạn đến với SahaShop !",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6!
                                    .color,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "1. Giới thiệu: Chào mừng bạn đến với sàn giao dịch thương mại điện tử SahaShop qua giao diện website hoặc ứng dụng di động (“Trang SahaShop”). Trước khi sử dụng Trang SahaShop hoặc tạo tài khoản SahaShop (“Tài Khoản”), vui lòng đọc kỹ các Điều Khoản Dịch Vụ dưới đây và Quy Chế Hoạt Động Sàn Giao Dịch Thương Mại Điện Tử SahaShop để hiểu rõ quyền lợi và nghĩa vụ hợp pháp của mình đối với Công ty cổ phần công nghệ Saha. “Dịch Vụ” chúng tôi cung cấp hoặc sẵn có bao gồm (a) Trang SahaShop, (b) các dịch vụ được cung cấp bởi Trang SahaShop và bởi phần mềm dành cho khách hàng của SahaShop có sẵn trên Trang SahaShop, và (c) tất cả các thông tin, đường dẫn, tính năng, dữ liệu, văn bản, hình ảnh, biểu đồ, âm nhạc, âm thanh, video (bao gồm cả các đoạn video được đăng tải trực tiếp theo thời gian thực (livestream)), tin nhắn, tags, nội dung, chương trình, phần mềm, ứng dụng dịch vụ (bao gồm bất kỳ ứng dụng dịch vụ di động nào) hoặc các tài liệu khác có sẵn trên Trang SahaShop hoặc các dịch vụ liên quan đến Trang SahaShop (“Nội Dung”). Bất kỳ tính năng mới nào được bổ sung hoặc mở rộng đối với Dịch Vụ đều thuộc phạm vi điều chỉnh của Điều Khoản Dịch Vụ này. Điều Khoản Dịch Vụ này điều chỉnh việc  bạn sử dụng Dịch Dụ cung cấp bởi SahaShop.",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6!
                                    .color,
                                height: 1.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          boxPermission(
                            "QUYỀN RIÊNG TƯ",
                            "2.1     SahaShop coi trọng việc bảo mật thông tin của bạn. Để bảo vệ quyền lợi người dùng, SahaShop cung cấp Chính Sách Bảo Mật tại SahaShop.vn để giải thích chi tiết các hoạt động bảo mật của SahaShop. Vui lòng tham khảo Chính Sách Bảo Mật để biết cách thức SahaShop thu thập và sử dụng thông tin liên quan đến Tài Khoản và/hoặc việc sử dụng Dịch Vụ của Người Sử Dụng (“Thông Tin Người Sử Dụng”). Điều Khoản Dịch Vụ này có liên quan mật thiết với Chính Sách Bảo Mật. Bằng cách sử dụng Dịch Vụ hoặc cung cấp thông tin trên Trang SahaShop, Người Sử Dụng:\n a.         cho phép SahaShop thu thập, sử dụng, công bố và/hoặc xử lý các Nội Dung, dữ liệu cá nhân của bạn và Thông Tin Người Sử Dụng như được quy định trong Chính Sách Bảo Mật;\nb.         đồng ý và công nhận rằng các thông tin được cung cấp trên Trang SahaShop sẽ thuộc sở hữu chung của bạn và SahaShop; và\nc.         sẽ không, dù là trực tiếp hay gián tiếp, tiết lộ các Thông Tin Người Sử Dụng cho bất kỳ bên thứ ba nào, hoặc bằng bất kỳ phương thức nào cho phép bất kỳ bên thứ ba nào được truy cập hoặc sử dụng Thông Tin Người Dùng của bạn.\n2.2       Trường hợp Người Sử Dụng sở hữu dữ liệu cá nhân của Người Sử Dụng khác thông qua việc sử dụng Dịch Vụ (“Bên Nhận Thông Tin”) theo đây đồng ý rằng, mình sẽ (i) tuân thủ mọi qui định pháp luật về bảo vệ an toàn thông tin cá nhân liên quan đến những thông tin đó; (ii) cho phép Người Sử Dụng là chủ sở hữu của các thông thông tin cá nhân mà Bên Nhận Thông Tin thu thập được (“Bên Tiết Lộ Thông Tin”) được phép xóa bỏ thông tin của mình được thu thập từ cơ sở dữ liệu của Bên Nhận Thông Tin; và (iii) cho phép Bên Tiết Lộ Thông Tin rà soát những thông tin đã được thu thập về họ bởi Bên Nhận Thông Tin, phù hợp với hoặc theo yêu cầu của các qui định pháp luật hiện hành.",
                          ),
                          boxPermission(
                            "GIỚI HẠN TRÁCH NHIỆM",
                            "3.1       SahaShop trao cho Người Sử Dụng quyền phù hợp để truy cập và sử dụng các Dịch Vụ theo các điều khoản và điều kiện được quy định trong Điều Khoản Dịch Vụ này. Tất cả các Nội Dung, thương hiệu, nhãn hiệu dịch vụ, tên thương mại, biểu tượng và tài sản sở hữu trí tuệ khác độc quyền (“Tài Sản Sở Hữu Trí Tuệ”) hiển thị trên Trang SahaShop đều thuộc sở hữu của SahaShop và bên sở hữu thứ ba, nếu có. Không một bên nào truy cập vào Trang SahaShop được cấp quyền hoặc cấp phép trực tiếp hoặc gián tiếp để sử dụng hoặc sao chép bất kỳ Tài Sản Sở Hữu Trí Tuệ nào, cũng như không một bên nào truy cập vào Trang SahaShop được phép truy đòi bất kỳ quyền, quyền sở hữu hoặc lợi ích nào liên quan đến Tài Sản Sở Hữu Trí Tuệ. Bằng cách sử dụng hoặc truy cập Dịch Vụ, bạn đồng ý tuân thủ các quy định pháp luật liên quan đến bản quyền, thương hiệu, nhãn hiệu dịch vụ hoặc bất cứ quy định pháp luật nào khác bảo vệ Dịch Vụ, Trang SahaShop và Nội Dung của Trang SahaShop. Bạn đồng ý không được phép sao chép, phát tán, tái bản, chuyển giao, công bố công khai, thực hiện công khai, sửa đổi, phỏng tác, cho thuê, bán, hoặc tạo ra các sản phẩm phái sinh của bất cứ phần nào thuộc Dịch Vụ, Trang SahaShop và Nội Dung của Trang SahaShop. Bạn không được nhân bản hoặc chỉnh sửa bất kỳ phần nào hoặc toàn bộ nội dung của Trang SahaShop trên bất kỳ máy chủ hoặc như là một phần của bất kỳ website nào khác mà chưa nhận được sự chấp thuận bằng văn bản của SahaShop. Ngoài ra, bạn đồng ý rằng bạn sẽ không sử dụng bất kỳ robot, chương trình do thám (spider) hay bất kỳ thiết bị tự động hoặc phương thức thủ công nào để theo dõi hoặc sao chép Nội Dung của SahaShop khi chưa có sự đồng ý trước bằng văn bản của SahaShop (sự chấp thuận này được xem như áp dụng cho các công cụ tìm kiếm cơ bản trên các webside tìm kiến trên mạng kết nối người dùng trực tiếp đến website đó).\n3.2       SahaShop cho phép kết nối từ website Người Sử Dụng đến Trang SahaShop, với điều kiện website của Người Sử Dụng không được hiểu là bất kỳ việc xác nhận hoặc liên quan nào đến SahaShop.",
                          ),
                          boxPermission(
                            "PHẦN MỀM",
                            "Bất kỳ phần mềm nào được cung cấp bởi SahaShop tới Người Sử Dụng đều thuộc phạm vi điều chỉnh của các Điều Khoản Dịch Vụ này. SahaShop bảo lưu tất cả các quyền liên quan đến phần mềm không được cấp một các rõ ràng bởi SahaShop theo đây. Bất kỳ tập lệnh hoặc mã code, liên kết đến hoặc dẫn chiếu từ Dịch Vụ, đều được cấp phép cho bạn bởi các bên thứ ba là chủ sở hữu của tập lệnh hoặc mã code đó chứ không phải bởi SahaShop.",
                          ),
                          boxPermission(
                            "TÀI KHOẢN VÀ BẢO MẬT",
                            "5.1       Một vài tính năng của Dịch Vụ chúng tôi yêu cầu phải đăng ký một Tài Khoản bằng cách lựa chọn một tên người sử dụng không trùng lặp (“Tên Đăng Nhập”) và mật khẩu đồng thời cung cấp một số thông tin cá nhân nhất định. Bạn có thể sử dụng Tài Khoản của mình để truy cập vào các sản phẩm, website hoặc dịch vụ khác mà SahaShop cho phép, có mối liên hệ hoặc đang hợp tác. SahaShop không kiểm tra và không chịu trách nhiệm đối với bất kỳ nội dung, tính năng năng, bảo mật, dịch vụ, chính sách riêng tư, hoặc cách thực hiện khác của các sản phẩm, website hay dịch vụ đó.. Trường hợp bạn sử dụng Tài Khoản của mình để truy cập vào các sản phẩm, website hoặc dịch vụ khác mà SahaShop cho phép, có mối liên hệ hoặc đang hợp tác, các điều khoản dịch vụ của những sản phẩm, website hoặc dịch vụ đó, bao gồm các chính sách bảo mật tương ứng vẫn được áp dụng khi bạn sử dụng các sản phẩm, website hoặc dịch vụ đó ngay cả khi những điều khoản dịch vụ này khác với Điều Khoản Dịch Vụ và/hoặc Chính Sách Bảo Mật của SahaShop.\n5.2       Bạn đồng ý (a) giữ bí mật mật khẩu và chỉ sử dụng Tên Đăng Nhập và mật khẩu khi đăng nhập, (b) đảm bảo bạn sẽ đăng xuất khỏi tài khoản của mình sau mỗi phiên đăng nhập trên Trang SahaShop, và (c) thông báo ngay lập tức với SahaShop nếu phát hiện bất kỳ việc sử dụng trái phép nào đối với Tài Khoản, Tên Đăng Nhập và/hoặc mật khẩu của bạn. Bạn phải chịu trách nhiệm với hoạt động dưới Tên Đăng Nhập và Tài Khoản của mình, bao gồm tổn thất hoặc thiệt hại phát sinh từ việc sử dụng trái phép liên quan đến mật khẩu hoặc từ việc không tuân thủ Điều Khoản này của Người Sử Dụng.\n5.3       Bạn đồng ý rằng SahaShop có toàn quyền xóa Tài Khoản và Tên Đăng Nhập của Người Sử Dụng ngay lập tức, gỡ bỏ hoặc hủy từ Trang SahaShop bất kỳ Nội Dung nào liên quan đến Tài Khoản và Tên Đăng Nhập của Người Sử Dụng với bất kỳ lý do nào mà có hoặc không cần thông báo hay chịu trách nhiệm với Người Sử Dụng hay bên thứ ba nào khác. Căn cứ để thực hiện các hành động này có thể bao gồm (a) Tài Khoản và Tên Đăng Nhập không hoạt động trong thời gian dài, (b) vi phạm điều khoản hoặc tinh thần của các Điều Khoản Dịch Vụ này, (c) có hành vi bất hợp pháp, lừa đảo, quấy rối, xâm phạm, đe dọa hoặc lạm dụng, (d) có nhiều tài khoản người dùng khác nhau, (e) mua sản phẩm trên Trang SahaShop với mục đích kinh doanh, (f) mua hàng số lượng lớn từ một Người Bán hoặc một nhóm Người Bán có liên quan, (g) lạm dụng mã giảm giá hoặc tài trợ hoặc quyền lợi khuyến mại (bao gồm việc bán mã giảm giá cho các bên thứ ba cũng như lạm dụng mã giảm giá ở Trang SahaShop), (h) có hành vi gây hại tới những Người Sử Dụng khác, các bên thứ ba hoặc các lợi ích kinh tế của SahaShop. Việc sử dụng Tài Khoản cho các mục đích bất hợp pháp, lừa đảo, quấy rối, xâm phạm, đe dọa hoặc lạm dụng có thể được gửi cho cơ quan nhà nước có thẩm quyền theo quy định pháp luật.\n5.4       Người Sử Dụng có thể yêu cầu xóa tài khoản bằng cách thông báo bằng văn bản đến SahaShop (tại đây). Tuy nhiên, Người Sử Dụng vẫn phải chịu trách nhiệm và nghĩa vụ đối với bất kỳ giao dịch nào chưa hoàn thành (phát sinh trước hoặc sau khi tài khoản bị xóa) hay việc vận chuyển hàng hóa liên quan đến tài khoản bị yêu cầu xóa. Khi đó, theo Điều Khoản Dịch Vụ, Người Sử Dụng phải liên hệ với SahaShop sau khi đã nhanh chóng và hoàn tất việc thực hiện và hoàn thành các giao dịch chưa hoàn tất. Người Sử Dụng chịu trách nhiệm đối với yêu cầu xóa tài khoản của mình.\n5.5       Bạn chỉ có thể sử dụng Dịch Vụ và/hoặc mở Tài Khoản tại SahaShop nếu bạn đáp ứng đủ các điều kiện để chấp nhận Điều Khoản Dịch Vụ này.",
                          ),
                          boxPermission(
                            "ĐIỀU KHOẢN SỬ DỤNG",
                            "6.1       Quyền được phép sử dụng Trang SahaShop và Dịch Vụ có hiệu lực cho đến khi bị chấm dứt. Quyền được phép sử dụng sẽ bị chấm dứt theo Điều Khoản Dịch Vụ này hoặc trường hợp Người Sử Dụng vi phạm bất cứ điều khoản hoặc điều kiện nào được quy định tại Điều Khoản Dịch Vụ này. Trong trường hợp đó, SahaShop có thể chấm dứt việc sử dụng của Người Sử Dụng bằng hoặc không cần thông báo.\n6.3       Người Sử Dụng hiểu rằng các Nội Dung, dù được đăng công khai hoặc truyền tải riêng tư, là hoàn toàn thuộc trách nhiệm của người đã tạo ra Nội Dung đó.  Điều đó nghĩa là bạn, không phải SahaShop, phải hoàn toàn chịu trách nhiệm đối với những Nội Dung mà bạn tải lên, đăng, gửi thư điện tử, chuyển tải hoặc bằng cách nào khác công khai trên Trang SahaShop. Người Sử Dụng hiểu rằng bằng cách sử dụng Trang SahaShop, bạn có thể gặp phải Nội Dung mà bạn cho là phản cảm, không đúng đắn hoặc chưa phù hợp. SahaShop sẽ không chịu trách nhiệm đối với Nội Dung, bao gồm lỗi hoặc thiếu sót liên quan đến Nội Dung, hoặc tổn thất hoặc thiệt hại xuất phát từ việc sử dụng, hoặc dựa trên, Nội Dung được đăng tải, gửi thư, chuyển tải hoặc bằng cách khác công bố trên Trang SahaShop.\n6.4       Người Sử Dụng thừa nhận rằng SahaShop và các bên được chỉ định của mình có toàn quyền (nhưng không có nghĩa vụ) sàng lọc, từ chối, xóa, dừng, tạm dừng, gỡ bỏ hoặc dời bất kỳ Nội Dung có sẵn trên Trang SahaShop, bao gồm bất kỳ Nội Dung hoặc thông tin nào bạn đã đăng.  SahaShop có quyền gỡ bỏ Nội Dung (i) xâm phạm đến Điều Khoản Dịch Vụ; (ii) trong trường hợp SahaShop nhận được khiếu nại hơp lệ theo quy định pháp luật từ Người Sử Dụng khác; (iii) trong trường hợp SahaShop nhận được thông báo hợp lệ về vi phạm quyền sở hữu trí tuệ hoặc yêu cầu pháp lý cho việc gỡ bỏ; hoặc (iv) những nguyên nhân khác theo quy định pháp luật. SahaShop có quyền chặn các liên lạc (bao gồm việc cập nhật trạng thái, đăng tin, truyền tin và/hoặc tán gẫu) về hoặc liên quan đến Dịch Vụ như nỗ lực của chúng tôi nhằm bảo vệ Dịch Vụ hoặc Người Sử Dụng của SahaShop, hoặc bằng cách khác thi hành các điều khoản trong Điều Khoản Dịch Vụ này. Người Sử Dụng đồng ý rằng mình phải đánh giá, và chịu mọi rủi ro liên quan đến, việc sử dụng bất kỳ Nội Dung nào, bao gồm bất kỳ việc dựa vào tính chính xác, đầy đủ, hoặc độ hữu dụng của Nội Dung đó. Liên quan đến vấn đề này, Người Sử Dụng thừa nhận rằng mình không phải và, trong giới hạn tối đa pháp luật cho phép, không cần dựa bào bất kỳ Nội Dung nào được tạo bởi SahaShop hoặc gửi cho SahaShop, bao gồm các thông tin trên các Diễn Đàn SahaShop hoặc trên các phần khác của Trang SahaShop.\n6.5       Người Sử Dụng chấp thuận và đồng ý rằng SahaShop có thể truy cập, duy trì và tiết lộ thông tin Tài Khoản của Người Sử Dụng trong trường hợp pháp luật có yêu cầu hoặc theo lệnh của tòa án hoặc cơ quan chính phủ hoặc cơ quan nhà nước có thẩm quyền yêu cầu SahaShop hoặc những nguyên nhân khác theo quy định pháp luật: (a) tuân thủ các thủ tục pháp luật; (b) thực thi Điều Khoản Dịch Vụ; (c) phản hồi các khiếu nại về việc Nội Dung xâm phạm đến quyền lợi của bên thứ ba; (d) phản hồi các yêu cầu của Người Sử Dụng liên quan đến chăm sóc khách hàng; hoặc (e) bảo vệ các quyền, tài sản hoặc an toàn của SahaShop, Người Sử Dụng và/hoặc cộng đồng.",
                          ),
                          boxPermission(
                            "VI PHẠM ĐIỀU KHOẢN DỊCH VỤ",
                            "7.1       Việc vi phạm chính sách này có thể dẫn tới một số hành động, bao gồm bất kỳ hoặc tất cả các hành động sau: \n-           Xóa danh mục sản phẩm; \n-           Giới hạn quyền sử dụng Tài Khoản;\n-           Đình chỉ và chấm dứt Tài Khoản; \n-           Thu hồi tiền/tài sản có được do hành vi gian lận, và các chi phí có liên quan như chi phí vận chuyển của đơn hàng, phí thanh toán…; \n-           Cáo buộc hình sự;\n-           Áp dụng biện pháp dân sự, bao gồm khiếu nại bồi thường thiệt hại và/hoặc áp dụng biện pháp khẩn cấp tạm thời; \n-           Các hành động hoặc biện pháp chế tài khác theo Tiêu Chuẩn Cộng Đồng, Quy Chế Hoạt Động, hoặc các Chính Sách SahaShop.\n7.2       Nếu bạn phát hiện Người Sử Dụng trên Trang SahaShop của chúng tôi có hành vi vi phạm Điều Khoản Dịch Vụ, vui lòng liên hệ SahaShop Tại đây.",
                          ),
                          boxPermission(
                            "VẬN CHUYỂN",
                            "8.1     Khi vận chuyển thành công đơn hàng, SahaShop sẽ thông báo đến Người Bán về việc đã nhận được tiền thanh toán từ phía Người Mua. Trừ trường hợp có thỏa thuận khác với SahaShop, Người Bán có trách nhiệm cung cấp đầy đủ thông tin tài khoản ngân hàng để SahaShop tiến hành chuyển tiền thanh toán cho đơn hàng đó.\n8.2     Người Bán phải luôn nỗ lực để đảm bảo Người Mua sẽ nhận được hàng đúng hẹn trong Thời Gian SahaShop Đảm Bảo.\n8.3     Người Sử Dụng hiểu rằng Người Bán chịu toàn bộ rủi ro liên quan đến việc vận chuyển hàng hóa được mua và bảo đảm rằng Người Bán đã hoặc sẽ mua bảo hiểm hàng hóa, bao gồm cả việc vận chuyển.  Trong trường hợp Hàng hóa được mua bị hư hỏng, thất lạc hoặc không chuyển phát được trong quá trình vận chuyển, Người Sử Dụng thừa nhận và đồng ý rằng SahaShop sẽ không chịu trách nhiệm đối với bất kỳ tổn thất, chi phí, phí tổn hoặc bất kỳ khoản phí nào phát sinh từ sự cố đó và Người Bán và/hoặc Người Mua sẽ liên hệ với đơn vị vận chuyển để giải quyết sự cố đó.\n8.4     Đối với Giao Dịch Xuyên Quốc Gia. Người Sử Dụng hiểu rằng, khi một đăng bán có mô tả rằng sản phẩm được đăng bán sẽ được gửi từ nước ngoài, sản phẩm đó được bán bởi Người Bán ngoài Việt Nam, và việc xuất/nhập khẩu sản phẩm đó chịu sự điều chỉnh của pháp luật nước sở tại.  Người Sử Dụng cần hiểu rõ các hạn chế về xuất/nhập khẩu hàng hóa của quốc gia nhập khẩu.  Người Sử Dụng đồng ý rằng SahaShop không thể tư vấn pháp lý liên quan đến vấn đề này và đồng ý rằng SahaShop sẽ không thể chịu các rủi ro hoặc trách nhiệm pháp lý đối với hoạt động xuất/nhập khẩu hàng hóa vào Việt Nam.",
                          ),
                          boxPermission(
                            "TRANH CHẤP",
                            "9.1     Trường hợp phát sinh vấn đề liên quan đến giao dịch, Người Bán và Người Mua đồng ý đầu tiên sẽ đối thoại với nhau để cố gắng giải quyết tranh chấp đó bằng thảo luận hai bên, và SahaShop sẽ cố gắng một cách hợp lý để thu xếp. Nếu vấn đề không được giải quyết bằng thảo luận hai bên, Người Sử Dụng có thể khiếu nại lên cơ quan có thẩm quyền của địa phương để giải quyết tranh chấp phát sinh đối với giao dịch.\n9.2     Mỗi Người Bán và Người Mua cam kết và đồng ý rằng mình sẽ không tiến hành thủ tục tố tụng hoặc bằng cách khác khiếu nại đối với SahaShop hoặc các công ty liên kết của SahaShop (trừ trường hợp SahaShop hoặc các công ty liên kết của mình là Người Bán sản phẩm liên quan đến khiếu nại đó) liên quan đến bất kỳ giao dịch nào được thực hiện trên Trang SahaShop hoặc bất kỳ tranh chấp nào liên quan đến giao dịch đó.\n9.3     Người Sử Dụng được áp dụng Chính Sách Đảm Bảo của SahaShop có thể gửi yêu cầu bằng văn bản tới SahaShop để được hỗ trợ giải quyết tranh chấp phát sinh từ giao dịch.  SahaShop sẽ thực hiện những bước cần thiết để hỗ trợ Người Sử Dụng giải quyết những tranh chấp này. Để biết thêm thông tin chi tiết, vui lòng xem Chính Sách Trả Hàng và Hoàn Tiền của SahaShop.\n9.4     Để rõ ràng hơn, việc hỗ trợ theo Mục 9 này chỉ áp dụng đối với Người Mua là đối tượng của Chính Sách Đảm Bảo của SahaShop.  Người Mua sử dụng những phương thức thanh toán khác có thể liên hệ trực tiếp với Người Bán.",
                          ),
                          boxPermission(
                            "LUẬT ÁP DỤNG",
                            "Các Điều Khoản Dịch Vụ này sẽ được điều chỉnh bởi và diễn giải theo luật pháp của Việt Nam.  Bất kỳ tranh chấp, tranh cãi, khiếu nại hoặc sự bất đồng dưới bất cứ hình thức nào phát sinh từ hoặc liên quan đến các Điều Khoản Dịch Vụ này chống lại hoặc liên quan đến SahaShop hoặc bất kỳ Bên Được Bồi Thường nào thuộc đối tượng của các Điều Khoản Dịch Vụ này sẽ được giải quyết bằng Trung Tâm Trọng Tài Quốc Tế Việt Nam (VIAC).  Ngôn ngữ phán xử của trọng tài là Tiếng Việt.",
                          ),
                          boxPermission(
                            "QUY ĐỊNH CHUNG",
                            "10.1     SahaShop bảo lưu tất cả các quyền lợi không được trao theo đây.\n10.2     SahaShop có quyền chỉnh sửa các Điều Khoản Dịch Vụ này vào bất cứ thời điểm nào thông qua việc đăng tải các Điều Khoản Dịch Vụ được chỉnh sửa lên Trang SahaShop.  Việc Người Dùng tiếp tục sử dụng Trang SahaShop sau khi việc thay đổi được đăng tải sẽ cấu thành việc Người Sử Dụng chấp nhận các Điều Khoản Dịch Vụ được chỉnh sửa.\n10.3     Người Sử Dụng không được phép chuyển giao, cấp lại quyền hoặc chuyển nhượng bất kỳ các quyền hoặc nghĩa vụ được cấp cho Người Sử Dụng theo đây.\n10.4     Không một quy định nào trong các Điều Khoản Dịch Vụ này sẽ cấu thành quan hệ đối tác, liên doanh hoặc quan hệ đại lý – chủ sở hữu giữa bạn và SahaShop.\n10.5     Tại bất kỳ hoặc các thời điểm nào, nếu SahaShop không thể thực hiện được bất kỳ điều khoản nào theo đây sẽ không ảnh hưởng, dưới bất kỳ hình thức nào, đến các quyền của SahaShop vào thời điểm sau đó để thực thi các quyền này trừ khi việc thư thi các quyền này được miễn trừ bằng văn bản.\n10.6     Các Điều Khoản Dịch Vụ này hoàn toàn phục vụ cho lợi ích của SahaShop và Người Sử Dụng mà vì lợi ích của bất kỳ cá nhân hay tổ chức nào khác, trừ các công ty liên kết và các công ty con của SahaShop (và cho từng bên kế thừa hay bên nhận chuyển giao của SahaShop hoặc của các công ty liên kết và công ty con của SahaShop).\n10.7     Các điều khoản được quy định trong Điều Khoản Dịch Vụ này và bất kỳ các thỏa thuận và chính sách được bao gồm hoặc được dẫn chiếu trong các Điều Khoản Dịch Vụ này cấu thành nên sự thỏa thuận và cách hiểu tổng thể của các bên đối với Dịch Vụ và Trang SahaShop và thay thế bất kỳ thỏa thuận hoặc cách hiểu trước đây giữa các bên liên quan đến vấn đề đó.   Với việc các bên giao kết thỏa thuận được tạo thành theo các Điều Khoản Dịch Vụ này, các bên không dựa vào bất kỳ tuyên bố, khẳng định, đảm bảo, cách hiểu, cam kết, lời hứa hoặc cam đoan nào của bất kỳ người nào trừ những điều được nêu rõ trong các Điều Khoản Dịch Vụ này.  Các Điều Khoản Dịch Vụ này có thể sẽ không mâu thuẫn, giải thích hoặc bổ sung như là bằng chứng của các thỏa thuận trước, bất kỳ thỏa thuận miệng hiện tại nào hoặc bất kỳ các điều khoản bổ sung nhất quán nào.\n10.8     Bạn đồng ý tuân thủ mọi quy định pháp luật hiện hành liên quan đến chống tham nhũng và chống hối lộ.\n10.9     Nếu bạn có bất kỳ câu hỏi hay thắc mắc nào liên quan đến Điều Khoản Dịch Vụ hoặc các vấn đề phát sinh liên quan đến Điều Khoản Dịch Vụ trên Trang SahaShop, vui lòng liên hệ SahaShop tại đây.",
                          ),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nhấn đồng ý để chấp nhận điều khoản của SahaShop",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => ServiceApp());
                          RulesApp().setAgreedRules(true);
                        },
                        child: Container(
                          width: Get.width - 50,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text("ĐỒNG Ý"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boxPermission(String title, String description) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(
              color: Theme.of(Get.context!).primaryTextTheme.headline6!.color,
              height: 1.5,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          description,
          style: TextStyle(
              color: Theme.of(Get.context!).primaryTextTheme.headline6!.color,
              height: 1.5),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
