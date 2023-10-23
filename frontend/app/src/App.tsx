import { ChangeEvent, useState, FC, useCallback, useContext } from "react";
import { BrowserRouter } from "react-router-dom";
// import { MemoList } from "./components/MemoList";
// import { useMemoList } from "./hooks/useMemoList";

// import { LoginUserContext } from "./providers/LoginUserProvider";
// import { SignUpButton } from "./components/SignUpButton";
import { Router } from "./router/Router";

export const App: FC = () => {
  // const { memos, addTodo, deleteTodo } = useMemoList();
  // const [text, setText] = useState<string>("");
  // const onChangeText = (e: ChangeEvent<HTMLInputElement>) => setText(e.target.value);

  // const onClickAdd = () => {
  //   addTodo(text);
  //   setText("");
  // };

  // const onClickDelete = useCallback((index: number) => {
  //   deleteTodo(index);
  // }, [deleteTodo]);

  return (
    <BrowserRouter>
      <Router />
    </BrowserRouter>
  );
};
