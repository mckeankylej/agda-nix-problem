{ mkDerivation, aeson, alex, array, async, base, binary, blaze-html
, boxes, bytestring, Cabal, containers, data-hash, deepseq
, directory, EdisonCore, edit-distance, emacs, equivalence
, exceptions, fetchgit, filemanip, filepath, geniplate-mirror
, gitrev, happy, hashable, hashtables, haskeline, ieee754, mtl
, murmur-hash, pretty, process, process-extras, QuickCheck
, regex-tdfa, regex-tdfa-text, split, stdenv, stm, strict, tasty
, tasty-hunit, tasty-quickcheck, tasty-silver, template-haskell
, temporary, text, time, transformers, unix-compat
, unordered-containers, uri-encode, zlib
}:
mkDerivation {
  pname = "Agda";
  version = "2.6.1";
  src = fetchgit {
    url = "https://github.com/agda/agda";
    sha256 = "17il1fgnn9mc47b921bz151imgjqch47nvh9d4c7956kjb95my9c";
    rev = "0ebc7407693fd09a525d4f2f35a3412b9deac8d1";
  };
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  setupHaskellDepends = [ base Cabal directory filepath process ];
  libraryHaskellDepends = [
    aeson array async base binary blaze-html boxes bytestring
    containers data-hash deepseq directory EdisonCore edit-distance
    equivalence exceptions filepath geniplate-mirror gitrev hashable
    hashtables haskeline ieee754 mtl murmur-hash pretty process
    regex-tdfa split stm strict template-haskell text time transformers
    unordered-containers uri-encode zlib
  ];
  libraryToolDepends = [ alex happy ];
  executableHaskellDepends = [ base directory filepath process ];
  executableToolDepends = [ emacs ];
  testHaskellDepends = [
    array base bytestring containers directory filemanip filepath mtl
    process process-extras QuickCheck regex-tdfa regex-tdfa-text tasty
    tasty-hunit tasty-quickcheck tasty-silver temporary text
    unix-compat uri-encode
  ];
  postInstall = ''
    files=("$data/share/ghc-"*"/"*"-ghc-"*"/Agda-"*"/lib/prim/Agda/"{Primitive.agda,Builtin"/"*.agda})
    for f in "''${files[@]}" ; do
      $out/bin/agda $f
    done
    for f in "''${files[@]}" ; do
      $out/bin/agda -c --no-main $f
    done
    $out/bin/agda-mode compile
  '';
  homepage = "http://wiki.portal.chalmers.se/agda/";
  description = "A dependently typed functional programming language and proof assistant";
  license = "unknown";
}
