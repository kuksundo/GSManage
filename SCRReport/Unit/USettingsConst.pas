unit USettingsConst;

interface

type

  ///  <summary>
  ///  <para>Enumeration of recognised sections within persistent storage.
  ///  </para>
  ///  <para>-ssFindText - info about last text search</para>
  ///  <para>-ssFindCompiler - info about last compiler search</para>
  ///  <para>-ssFindXRefs - info about last XRef search</para>
  ///  <para>-ssCompilerInfo - info about each supported compiler</para>
  ///  <para>-ssPreferences - info about program preferences</para>
  ///  <para>-ssUnits - list of default units</para>
  ///  <para>-ssDuplicateSnippet - persistent settings from Duplicate Snippets
  ///  dlg</para>
  ///  <para>-ssFavourites - persistent settings from Favourites dlg</para>
  ///  <para>-ssWindowState - info about the size and state of various
  ///  windows</para>
  ///  <para>-ssDatabase - database customisation info</para>
  ///  <para>-ssCompilers - info about all compilers</para>
  ///  </summary>
  TSettingsSectionId = (
    ssFindText, ssFindCompiler, ssFindXRefs, ssCompilerInfo,
    ssPreferences, ssUnits, ssDuplicateSnippet,
    ssFavourites, ssWindowState, ssDatabase, ssCompilers
  );

const
  DEFAULT_RECIPE_INFO_FILENAME = 'SCR_Recipe_Json.txt';
  DEFAULT_RECIPE_DIV_FILENAME = 'SCR_Recipe_JsonSCRRecipeDivisionList.txt';

  // Map of section ids to names
  cSectionNames: array[TSettingsSectionId] of string = (
    'FindText',         // ssFindText
    'FindCompiler',     // ssFindCompiler
    'FindXRefs',        // ssFindXRefs
    'Cmp',              // ssCompilerInfo
    'Prefs',            // ssPreferences
    'UnitList',         // ssUnits
    'DuplicateSnippet', // ssDuplicateSnippet
    'Favourites',       // ssFavourites
    'WindowState',      // ssWindowState
    'Database',         // ssDatabase
    'Compilers'         // ssCompilers
  );

implementation

end.
