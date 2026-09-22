# External URLs used by MyInoface

Defined in `lib/core/util/url_service.dart` unless noted. All Inoser JSON calls are **HTTP POST** with form field `inoface_ws`.

School code (`{codeSchool}`) comes from login (example: `lcj`). Pattern:

```
https://inoser-education.com/{codeSchool}/json/{service}
```

The API is called over HTTPS. The server currently uses a self-signed certificate; the app pins that cert in `lib/core/network/inoser_http_overrides_io.dart`.

---

## Inoser Education API

### School-scoped (`https://inoser-education.com/{codeSchool}/json/…`)

| Service | Full URL | Used for |
| --- | --- | --- |
| `login_ws` | `https://inoser-education.com/{codeSchool}/json/login_ws` | Email/password login |
| `login_with_Qrcode_ws` | `https://inoser-education.com/{codeSchool}/json/login_with_Qrcode_ws` | QR login (after school URL is resolved) |
| `Forget_password_ws` | `https://inoser-education.com/{codeSchool}/json/Forget_password_ws` | Forgot password |
| `GetAllClasses_ws` | `https://inoser-education.com/{codeSchool}/json/GetAllClasses_ws` | Class list |
| `GetElevesByIdClasse_ws` | `https://inoser-education.com/{codeSchool}/json/GetElevesByIdClasse_ws` | Students in a class |
| `GetElevesByQuery_ws` | `https://inoser-education.com/{codeSchool}/json/GetElevesByQuery_ws` | Student search |
| `AutoCompleteSearch_ws` | `https://inoser-education.com/{codeSchool}/json/AutoCompleteSearch_ws` | Student autocomplete |
| `GetDemandesRecuperationsByIdClasse` | `https://inoser-education.com/{codeSchool}/json/GetDemandesRecuperationsByIdClasse` | Pickup requests by class |
| `add_demanderecuperation_encadrant_ws` | `https://inoser-education.com/{codeSchool}/json/add_demanderecuperation_encadrant_ws` | Create pickup request |
| `remove_demanderecuperation_ws` | `https://inoser-education.com/{codeSchool}/json/remove_demanderecuperation_ws` | Delete pickup request |
| `Recuperation_ws` | `https://inoser-education.com/{codeSchool}/json/Recuperation_ws` | Confirm pickup |
| `GetAllGardesByDate_ws` | `https://inoser-education.com/{codeSchool}/json/GetAllGardesByDate_ws` | Duty list by date |
| `GetPersonneGardeByDate_ws` | `https://inoser-education.com/{codeSchool}/json/GetPersonneGardeByDate_ws` | People on duty for a date |
| `GetParentsByid_ws` | `https://inoser-education.com/{codeSchool}/json/GetParentsByid_ws` | Parent by person id |
| `GetParentCinByid_ws` | `https://inoser-education.com/{codeSchool}/json/GetParentCinByid_ws` | Parent CIN images |

Commented (not called): `login_admin_ws`, `login_admin_with_Qrcode_ws`.

### Hardcoded (not school-scoped)

| URL | Used for |
| --- | --- |
| `https://inoser-education.com/lescopains/json/GetUrlFromQrcode_ws` | Resolve school from QR scan |

### URLs returned by the API (not hardcoded)

Student photos (`eleve_photo`) and CIN images (`cinRecto` / `cinVerso`) are loaded with `CachedNetworkImage`. PDFs can be opened with `PDFDocument.fromURL(path)` in `lib/core/ui/open_pdf.dart`. Those hosts depend on the JSON payload (typically still `inoser-education.com`).

---

## Firebase (`myinoface`)

Configured in `lib/firebase_options.dart`, `android/app/google-services.json`, and `ios/Runner/GoogleService-Info.plist`.

| Resource | URL / host |
| --- | --- |
| Storage bucket | `https://myinoface.appspot.com` |
| Cloud Firestore (SDK; package present) | `https://firestore.googleapis.com` |
| FCM / installations (SDK) | `https://firebaseinstallations.googleapis.com`, `https://fcmtoken.googleapis.com`, `https://firebase.googleapis.com` |

Project number: `256012514157`.

---

## Other runtime hosts (libraries)

| URL | Why |
| --- | --- |
| `https://dummyapi.online/api/movies/1` | Connectivity check (`internet_connection_checker`) |
| `https://jsonplaceholder.typicode.com/albums/1` | Connectivity check |
| `https://fakestoreapi.com/products/1` | Connectivity check |
| `https://fonts.googleapis.com` / `https://fonts.gstatic.com` | `google_fonts` (Acme, ABeeZee) |

---

## Example with school code `lcj`

- `https://inoser-education.com/lcj/json/login_ws`
- `https://inoser-education.com/lcj/json/GetAllClasses_ws`
- `https://inoser-education.com/lcj/json/GetPersonneGardeByDate_ws`
- `https://inoser-education.com/lescopains/json/GetUrlFromQrcode_ws`
