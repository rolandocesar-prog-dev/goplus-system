/// Biblioteca core compartida para todas las aplicaciones GoPlus
///
/// Contiene constantes, modelos, servicios, tema y widgets comunes.
library goplus_core;

// Constants
export 'src/constants/app_constants.dart';
export 'src/constants/error_constants.dart';

// Models
export 'src/models/user_model.dart';
export 'src/models/order_model.dart';

// Services
export 'src/services/navigation_service.dart';
export 'src/services/local_storage_service.dart';

// Theme
export 'src/theme/app_theme.dart';
export 'src/theme/app_colors.dart';
export 'src/theme/app_text_styles.dart';

// Utils
export 'src/utils/validators.dart';
export 'src/utils/formatters.dart';

// Widgets
export 'src/widgets/app_button.dart';
export 'src/widgets/app_text_field.dart';
export 'src/widgets/error_widget.dart';
export 'src/widgets/loading_widget.dart';
