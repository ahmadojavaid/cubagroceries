import '../model/booking_model.dart';
import '../model/hotel_model.dart';
import '../model/notification.dart';
import '../model/search_data_model.dart';
import '../model/save_data_model.dart';
import '../store/hoteldata.dart';
import '../store/theme_store.dart';

List<HotelModel> hotelCard = getHotleList();
List<Bookings> demoUpcomingBookings = bookingUpcomingData();
List<Bookings> demoPastBookings = bookingPostData();
List<NotificationItem> notifications = Notifications();
List<Hotel> savedata = saveData();
List<Searchdata> searchdatas = searchdata();
ThemeStore store = ThemeStore();
HotelStorecard Hotelstorecard = HotelStorecard();