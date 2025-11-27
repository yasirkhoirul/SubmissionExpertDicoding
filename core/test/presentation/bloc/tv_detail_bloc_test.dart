import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/presentation/bloc/get_detail_tv_series/bloc/get_detail_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockusecasegetDetail;
  late MockSaveWatchlistTv mockusecasesavewatchlisttv;
  late MockRemoveWatchlistTv mockusecaseremovewatchlisttv;
  late MockGetWatchlistStatusTv mockusecasegetstatus;
  late GetDetailTvSeriesBloc getTVSeriesDetailBloc;

  setUp(() {
    mockusecaseremovewatchlisttv = MockRemoveWatchlistTv();
    mockusecasegetstatus = MockGetWatchlistStatusTv();
    mockusecasegetDetail = MockGetTvSeriesDetail();
    mockusecasesavewatchlisttv = MockSaveWatchlistTv();
    getTVSeriesDetailBloc = GetDetailTvSeriesBloc(
      mockusecasegetDetail,
      mockusecasesavewatchlisttv,
      getWatchListStatus: mockusecasegetstatus, removeWatchlistTv: mockusecaseremovewatchlisttv,
    );
  });

  final datadummy = TvSeriesDetail(
    name: "",
    poster_path: "poster_path",
    overview: "0.0,",
    rating: 0.0,
    reviewer: 2,
    episode: 2,
    season: 12,
    id: 1,
  );

  blocTest(
    "testing get detail return data detail",
    build: () {
      when(
        mockusecasegetDetail.execute(1),
      ).thenAnswer((realInvocation) async => Right(datadummy));
      return getTVSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnDetailTvSeriesE(1)),

    expect: () => [
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: null,
        tvseriesstatus: RequestState.Loading,
        watchlistmessage: "",
        watchliststatus: false,
      ),
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: datadummy,
        tvseriesstatus: RequestState.Loaded,
        watchlistmessage: "",
        watchliststatus: false,
      ),
    ],
  );

  blocTest(
    "testing get detail return fail connec",
    build: () {
      when(
        mockusecasegetDetail.execute(1),
      ).thenAnswer((realInvocation) async => Left(ConnectionFailure("")));
      return getTVSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnDetailTvSeriesE(1)),

    expect: () => [
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: null,
        tvseriesstatus: RequestState.Loading,
        watchlistmessage: "",
        watchliststatus: false,
      ),
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: null,
        tvseriesstatus: RequestState.Error,
        watchlistmessage: "",
        watchliststatus: false,
      ),
    ],
  );

  blocTest(
    "testing get detail return fail connec",
    build: () {
      when(
        mockusecasegetDetail.execute(1),
      ).thenAnswer((realInvocation) async => Left(ServerFailure("")));
      return getTVSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnDetailTvSeriesE(1)),

    expect: () => [
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: null,
        tvseriesstatus: RequestState.Loading,
        watchlistmessage: "",
        watchliststatus: false,
      ),
      GetDetailTvSeriesState(
        detailmessage: "",
        tvSeriesDetail: null,
        tvseriesstatus: RequestState.Error,
        watchlistmessage: "",
        watchliststatus: false,
      ),
    ],
  );

  group("testing watchlist", () {
    blocTest(
      "testing detail add watchlist succes",
      build: () {
        when(
          mockusecasesavewatchlisttv.execute(datadummy),
        ).thenAnswer((realInvocation) async => Right("berhasil disimpan"));
        return getTVSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchListTv(datadummy)),
      expect: () => [
        GetDetailTvSeriesState(
          detailmessage: "",
          tvSeriesDetail: null,
          tvseriesstatus: RequestState.Empty,
          watchlistmessage: "berhasil disimpan",
          watchliststatus: false,
        ),
        GetDetailTvSeriesState(
          detailmessage: "",
          tvSeriesDetail: null,
          tvseriesstatus: RequestState.Empty,
          watchlistmessage: "berhasil disimpan",
          watchliststatus: true,
        ),
      ],
    );
    blocTest(
      "testing detail add watchlis fail database",
      build: () {
        when(
          mockusecasesavewatchlisttv.execute(datadummy),
        ).thenAnswer((realInvocation) async => Left(DatabaseFailure("gagal")));
        return getTVSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchListTv(datadummy)),
      expect: () => [
        GetDetailTvSeriesState(
          detailmessage: "",
          tvSeriesDetail: null,
          tvseriesstatus: RequestState.Empty,
          watchlistmessage: "gagal",
          watchliststatus: false,
        ),
      ],
    );
  });

  blocTest("testing status and succes return true", build: () {
    when(mockusecasegetstatus.execute(1)).thenAnswer((realInvocation) async => true ,);
    return getTVSeriesDetailBloc;
  },
  act: (bloc) => bloc.add(IsAddedOnWatchList(1)),
  expect: () => [GetDetailTvSeriesState(watchliststatus: true)],
  );
  blocTest("testing status and fail return false", build: () {
    when(mockusecasegetstatus.execute(1)).thenAnswer((realInvocation) async => false ,);
    return getTVSeriesDetailBloc;
  },
  act: (bloc) => bloc.add(IsAddedOnWatchList(1)),
  expect: () => [GetDetailTvSeriesState(watchliststatus: false)],
  );

  group("testing remove watchlist tv", (){
    blocTest("testing on succes", build: (){

      when(mockusecaseremovewatchlisttv.excute(datadummy)).thenAnswer((realInvocation) async=> Right("sukses menghapus") ,);
      return getTVSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchListTv(datadummy)),
    expect: () => [
      GetDetailTvSeriesState(
          detailmessage: "",
          tvSeriesDetail: null,
          tvseriesstatus: RequestState.Empty,
          watchlistmessage: "sukses menghapus",
          watchliststatus: false,
        ),
    ],
    );
    blocTest("testing on succes", build: (){

      when(mockusecaseremovewatchlisttv.excute(datadummy)).thenAnswer((realInvocation) async=> Left(DatabaseFailure("gagal menghapus")) ,);
      return getTVSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchListTv(datadummy)),
    expect: () => [
      GetDetailTvSeriesState(
          detailmessage: "",
          tvSeriesDetail: null,
          tvseriesstatus: RequestState.Empty,
          watchlistmessage: "gagal menghapus",
          watchliststatus: false,
        ),
    ],
    );
  });
}
