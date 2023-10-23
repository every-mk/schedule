import { FC } from "react";

type Props = {
  memos: string[];
  onClickDelete: (index: number) => void;
};

export const MemoList: FC<Props> = props => {
  const { memos, onClickDelete } = props;

  return (
    <div>
      <p>メモ一覧</p>
      <ul>
        {memos.map((memo, index) => (
          <li key={memo}>
            <div>
              <p>{memo}</p>
              <button onClick={() => onClickDelete(index)}>削除</button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
};
