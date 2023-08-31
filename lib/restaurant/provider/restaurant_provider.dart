import 'package:flutter_edu_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_edu_app/common/model/pagination_params.dart';
import 'package:flutter_edu_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
        (ref) {
      final repository = ref.watch(restaurantRepositoryProvider);
      return RestaurantStateNotifier(repository: repository);
    });

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate({
    int fetchCount = 20,
    //추가 데이터 가져오기 true- 추가로 데이터 더가져옴, false - 새로고침
    bool fetchMore = false,
    // 강제 다시 로
    bool forceRefetch = false,
  }) async {
    // State의 5가지 상태
    //
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
    // 3) CursorPaginationError - 에러가 있는 상태
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
    // 5) CursorPaginationFetchMore - 추가 데이터를 pagiante 해오라는 요청을 받았을때

    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination;

      if (!pState.meta.hasMore) {
        return;
      }
    }

    final isLoading = state is CursorPaginationLoading;
    final isRefetching = state is CursorPaginationRefetching;
    final isFetching = state is CursorPaginationFetchingMore;

    if (fetchMore && (isLoading || isRefetching || isFetching)) {
      return;
    }

    // PaginationParams 생성
    PaginationParams paginationParams = PaginationParams(
      count: fetchCount,
    );

    if (fetchMore) {
      final pState = state as CursorPagination;

      state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data
      );

      paginationParams = paginationParams.copyWith(
          after: pState.data.last.id
      );
    }

    final result = await repository.paginate(
      paginationParams: paginationParams,
    );

    if(state is CursorPaginationFetchingMore) {
      final pState = state as CursorPaginationFetchingMore;

      state = result.copyWith(
        // 기존 데이터에 새로운 데이터 추가
        data: [
          ...pState.data,
          ...result.data,
        ],
      );
    }
  }
}
